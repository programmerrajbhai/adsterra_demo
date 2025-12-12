import 'package:flutter/material.dart';
import 'package:adsterra_demo/ui/facebook_ad_card.dart';

void main() {
  runApp(const AdsterraDemoApp());
}

class AdsterraDemoApp extends StatelessWidget {
  const AdsterraDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meetyarah',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5), // Facebook Background Color
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 1,
          titleTextStyle: TextStyle(color: Color(0xFF1877F2), fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
      ),
      home: const FeedPage(),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final List<dynamic> _items = [];

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  void _loadFeed() {
    for (int i = 0; i < 20; i++) {
      _items.add({'type': 'post', 'id': i});
      if ((i + 1) % 3 == 0) { // প্রতি ৩ পোস্ট পর পর অ্যাড
        _items.add({'type': 'ad', 'id': 'ad_$i'});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("facebook"), // Logo Text
        actions: [
          _circleBtn(Icons.search),
          _circleBtn(Icons.message_rounded),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          if (item['type'] == 'ad') {
            return FacebookAdCard(
              viewId: item['id'],
              directLink: "https://your-direct-link.com",
            );
          }
          return _buildRealPost(item['id']);
        },
      ),
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: Icon(icon, color: Colors.black, size: 22),
    );
  }

  // 📝 রিয়েলিস্টিক পোস্ট উইজেট
  Widget _buildRealPost(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${index + 10}'),
            ),
            title: Text("User Name $index", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row(children: const [Text("2h • "), Icon(Icons.public, size: 12, color: Colors.grey)]),
            trailing: const Icon(Icons.more_horiz),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text("Here is a beautiful photo from my recent trip! Flutter web is amazing. 💙 #Travel #Code", style: TextStyle(fontSize: 14)),
          ),
          // Image
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[300],
            child: Image.network('https://picsum.photos/500/300?random=$index', fit: BoxFit.cover),
          ),
          // Stats
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("👍 ❤️ 1.2K"),
                Text("24 Comments • 5 Shares"),
              ],
            ),
          ),
          const Divider(height: 1),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionBtn(Icons.thumb_up_off_alt, "Like"),
              _actionBtn(Icons.chat_bubble_outline, "Comment"),
              _actionBtn(Icons.share_outlined, "Share"),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(children: [Icon(icon, color: Colors.grey[600]), const SizedBox(width: 5), Text(text, style: TextStyle(color: Colors.grey[600]))]),
    );
  }
}