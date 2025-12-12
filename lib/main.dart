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
      title: 'Meetyarah Feed',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
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
    // ২০টি পোস্ট জেনারেট এবং অ্যাড মিক্স করা
    for (int i = 0; i < 20; i++) {
      _items.add({'type': 'post', 'id': i});
      if ((i + 1) % 3 == 0) { // ৩ পোস্ট পর পর অ্যাড
        _items.add({'type': 'ad', 'id': 'ad_$i'});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("facebook", style: TextStyle(color: Color(0xFF1877F2), fontWeight: FontWeight.bold, fontSize: 26)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];

          // অ্যাড কার্ড
          if (item['type'] == 'ad') {
            return FacebookAdCard(
              viewId: item['id'],
              directLink: "https://your-direct-link.com", // এখানে আপনার Direct Link দিন
            );
          }

          // রিয়েলিস্টিক ডামি পোস্ট
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  CircleAvatar(backgroundColor: Colors.grey[300]),
                  const SizedBox(width: 10),
                  Text("User ${item['id']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 10),
                const Text("This is a beautiful post about Flutter development. 💙"),
                const SizedBox(height: 10),
                Container(height: 200, color: Colors.grey[200]),
              ],
            ),
          );
        },
      ),
    );
  }
}