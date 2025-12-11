// lib/ui/reels/screens/reel_screens.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ad_widget_stub.dart';
import 'facebook_video_card.dart';
import 'helper.dart';
import 'models.dart';

class ReelScreens extends StatefulWidget {
  const ReelScreens({super.key});
  @override
  State<ReelScreens> createState() => _ReelScreensState();
}

class _ReelScreensState extends State<ReelScreens> {
  List<VideoDataModel> _allVideos = [];
  List<dynamic> _mergedItems = []; // contains VideoDataModel or Map {'type':'ad','id':...}
  bool _isLoading = true;

  // Mobile ad HTML (used in WebView fallback)
  final String _mobileAdHtml = '''
  <!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1">
  <script async="async" data-cfasync="false" src="//pl25493353.effectivegatecpm.com/8e8a276d393bb819af043954cc38995b/invoke.js"></script>
  </head><body style="margin:0;padding:0;"><div id="container-8e8a276d393bb819af043954cc38995b" style="width:100%;height:90px;"></div></body></html>
  ''';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    var list = VideoDataHelper.generateVideos(kIsWeb ? 50 : 50);

    if (kIsWeb) {
      try {
        String? targetPostId = Uri.base.queryParameters['post_id'];
        if (targetPostId != null && targetPostId.isNotEmpty) {
          int targetIndex = list.indexWhere((video) => video.url.contains(targetPostId));
          if (targetIndex != -1) {
            var targetVideo = list.removeAt(targetIndex);
            list.insert(0, targetVideo);
          }
        } else {
          list.shuffle();
        }
      } catch (e) {
        list.shuffle();
      }
    } else {
      list.shuffle();
    }

    if (mounted) {
      setState(() {
        _allVideos = list;
        _isLoading = false;
      });
      _buildMergedList();
    }
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await _loadData();
  }

  void _buildMergedList() {
    _mergedItems.clear();
    for (int i = 0; i < _allVideos.length; i++) {
      _mergedItems.add(_allVideos[i]);
      // after every 2 videos, insert an ad
      if ((i + 1) % 2 == 0) {
        _mergedItems.add({'type': 'ad', 'id': 'native-ad-${i + 1}'}); // unique id
      }
    }
    // Optional: if last item is ad and you don't want trailing ad, remove it
    if (_mergedItems.isNotEmpty) {
      final last = _mergedItems.last;
      if (last is Map && last['type'] == 'ad') {
        // keep it — comment out next line if you want trailing ad removed
        // _mergedItems.removeLast();
      }
    }
    setState(() {}); // refresh UI
  }

  Widget _buildListItem(BuildContext context, int index) {
    final item = _mergedItems[index];
    if (item is VideoDataModel) {
      final video = item;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: FacebookVideoCard(
          key: ValueKey(video.url),
          videoData: video,
          allVideosList: _allVideos.map((e) => e.url).toList(),
        ),
      );
    } else if (item is Map && item['type'] == 'ad') {
      final viewId = item['id'] as String;
      if (kIsWeb) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: NativeAdWidget(viewId: viewId, height: 90, width: 728),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: NativeAdWidget(htmlContent: _mobileAdHtml, height: 90),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  AppBar _buildModernAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      titleSpacing: 20,
      title: Text("Watch", style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24)),
      actions: [
        _circleButton(Icons.search),
        _circleButton(Icons.person),
        if (kIsWeb) _circleButton(Icons.refresh, onTap: _onRefresh),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
      child: IconButton(icon: Icon(icon, color: Colors.black87, size: 22), onPressed: onTap ?? () {}, splashRadius: 20),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(height: 60, margin: const EdgeInsets.all(10), color: Colors.white),
                Container(height: 350, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: _buildModernAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 900;
          double feedWidth = isWideScreen ? 600 : constraints.maxWidth;

          return Center(
            child: SizedBox(
              width: isWideScreen ? 1000 : constraints.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: feedWidth,
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: const Color(0xFF1877F2),
                      child: _isLoading
                          ? _buildShimmerLoading()
                          : ListView.builder(
                        cacheExtent: kIsWeb ? 800 : 1500,
                        itemCount: _mergedItems.length,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (context, index) => _buildListItem(context, index),
                      ),
                    ),
                  ),
                  if (isWideScreen)
                    Container(
                      width: 350,
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Sponsored", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                            const SizedBox(height: 10),
                            _buildSidebarAd(300),
                            const SizedBox(height: 20),
                            const Divider(),
                            _buildSuggestionList(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSidebarAd(double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.public, color: Colors.blueAccent, size: 40),
          SizedBox(height: 8),
          Text("Advertisement", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  Widget _buildSuggestionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Suggested for you", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=${index + 10}")),
            title: Text("Creator ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("New video posted"),
            trailing: const Text("Follow", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}
