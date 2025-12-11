// lib/ui/reels/facebook_video_card.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'models.dart';

class FacebookVideoCard extends StatefulWidget {
  final VideoDataModel videoData;
  final List<String> allVideosList;

  const FacebookVideoCard({
    super.key,
    required this.videoData,
    required this.allVideosList,
  });

  @override
  State<FacebookVideoCard> createState() => _FacebookVideoCardState();
}

class _FacebookVideoCardState extends State<FacebookVideoCard> with TickerProviderStateMixin {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPreviewing = false;
  bool _isLiked = false;
  bool _showHeart = false;

  late AnimationController _heartAnimationController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _heartAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _heartScale = Tween<double>(begin: 0.0, end: 1.2).animate(CurvedAnimation(parent: _heartAnimationController, curve: Curves.elasticOut));
    _heartAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() => _showHeart = false);
          _heartAnimationController.reset();
        });
      }
    });
  }

  void _initializeVideo() {
    try {
      String url = widget.videoData.url.replaceFirst("http://", "https://");
      _controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          if (mounted) {
            setState(() => _isInitialized = true);
            _controller?.setVolume(0);
          }
        }).catchError((e) {
          debugPrint("Video init error: $e");
        });
    } catch (e) {
      debugPrint("Video init exception: $e");
    }
  }

  void _onDoubleTapLike() {
    setState(() {
      _showHeart = true;
      _isLiked = true;
    });
    _heartAnimationController.forward();
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.videoData;
    return Card(
      margin: EdgeInsets.only(bottom: kIsWeb ? 16 : 8),
      elevation: 0.5,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: CircleAvatar(backgroundImage: NetworkImage(video.profileImage)),
            title: Text(video.channelName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Text("${video.timeAgo} · 🌎", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            trailing: const Icon(Icons.more_horiz),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(video.title, style: const TextStyle(fontSize: 15)),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onDoubleTap: _onDoubleTapLike,
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: _isInitialized
                  ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio > 1 ? _controller!.value.aspectRatio : 16 / 9,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller!),
                    if (_showHeart)
                      ScaleTransition(scale: _heartScale, child: const Icon(Icons.favorite, color: Colors.white, size: 100)),
                  ],
                ),
              )
                  : const SizedBox(height: 300, child: Center(child: CircularProgressIndicator(color: Colors.white))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(_isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined, color: _isLiked ? Colors.blue : Colors.grey[700], size: 20),
                  const SizedBox(width: 4),
                  Text(video.views, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ]),
                Text("${video.comments} Comments  •  ${video.likes} Shares", style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
