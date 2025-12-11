// lib/ui/reels/helper.dart
import 'dart:math';
import 'models.dart';

class VideoDataHelper {
// helper.dart: replace profile image list with picsum (CORS friendly)
  static final List<String> _profileImages = [
    'https://picsum.photos/seed/1/150',
    'https://picsum.photos/seed/2/150',
    'https://picsum.photos/seed/3/150',
    'https://picsum.photos/seed/4/150',
    'https://picsum.photos/seed/5/150',
  ];


  static final List<String> _names = ["Sofia Rose", "Anika Vlogz", "Misty Night", "Bella X", "Desi Queen", "Ryan Star", "Zara Life"];
  static final List<String> _titles = ["Viral Video 🔥", "Late night fun 🤫", "My new dance cover 💃", "Behind the scenes...", "Must Watch! 😱"];
  static final List<String> _bios = [
    "💃 Professional Dancer & Choreographer.\n✨ Creating magic with moves.\n👇 Subscribe for exclusive tutorials!",
    "📸 Travel Vlogger exploring the world.\n✈️ Catch me if you can!\n❤️ Love to meet new people.",
    "Fitness Coach & Model 💪\nHelping you get in shape.\nDM for personalized diet plans! 🥗",
    "Digital Artist & Content Creator 🎨\nSharing my daily life and art.\nThanks for the support! ✨",
    "Just a girl living her dream. 💖\nFashion | Lifestyle | Beauty\nBusiness inquiries available via button above."
  ];
  static final List<String> _services = [
    "I offer shoutouts, personalized dance videos, and 1-on-1 video calls. Join my premium to see exclusive behind-the-scenes content!",
    "Available for brand collaborations, modeling shoots, and travel guidance. Check my premium for uncensored travel vlogs.",
    "Personal diet plans, workout routines, and motivational calls. Premium members get daily updates!",
    "Custom artwork requests, digital portrait drawing, and art tutorials available."
  ];

  static List<String> _generateImages(int count, int seed) => List.generate(count, (i) => "https://picsum.photos/seed/${seed + i}/400/600");

  static List<VideoDataModel> generateVideos(int count) {
    var random = Random();
    return List.generate(count, (index) {
      int id = 64000 + index;
      return VideoDataModel(
        url: 'https://ser3.masahub.cc/myfiless/id/$id.mp4',
        title: _titles[random.nextInt(_titles.length)],
        channelName: _names[random.nextInt(_names.length)],
        profileImage: _profileImages[random.nextInt(_profileImages.length)],
        bio: _bios[random.nextInt(_bios.length)],
        serviceOverview: _services[random.nextInt(_services.length)],
        views: "${(random.nextDouble() * 5 + 0.1).toStringAsFixed(1)}M",
        likes: "${random.nextInt(50) + 5}K",
        comments: "${random.nextInt(1000) + 100}",
        subscribers: "${(random.nextDouble() * 2 + 0.5).toStringAsFixed(1)}M",
        premiumSubscribers: "${random.nextInt(50) + 10}K",
        contactPrice: "\$${random.nextInt(50) + 20}",
        timeAgo: "${random.nextInt(23) + 1}h",
        duration: "0:30",
        clientFeedback: "Amazing content!",
        isVerified: random.nextBool(),
        freeContentImages: _generateImages(9, index * 10),
        premiumContentImages: _generateImages(12, index * 20),
      );
    });
  }
}
