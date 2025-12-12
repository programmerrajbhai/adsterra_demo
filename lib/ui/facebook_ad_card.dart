import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:math';
import 'package:adsterra_demo/ui/native_ad_widget.dart';

class FacebookAdCard extends StatelessWidget {
  final String viewId;
  final String directLink;

  FacebookAdCard({
    super.key,
    required this.viewId,
    required this.directLink,
  });

  // ডামি ডাটা
  final List<String> _names = ["App Store", "Game Center", "Tech Daily", "Viral Zone"];
  final List<String> _buttons = ["Install Now", "Play Game", "Watch Video", "Get Offer"];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final String name = _names[random.nextInt(_names.length)];
    final String btnText = _buttons[random.nextInt(_buttons.length)];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔵 HEADER (Clickable)
          InkWell(
            onTap: () => html.window.open(directLink, '_blank'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade200),
                      image: const DecorationImage(
                        image: NetworkImage("https://cdn-icons-png.flaticon.com/512/732/732221.png"), // Microsoft/App icon style
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Name & Badge
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: Colors.blue, size: 14), // Verified Badge
                        ],
                      ),
                      const Text("Sponsored • Suggested for you", style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz, color: Colors.grey),
                ],
              ),
            ),
          ),

          // 📺 AD BODY
          Container(
            width: double.infinity,
            color: const Color(0xFFFAFAFA),
            alignment: Alignment.center,
            child: NativeAdWidget(viewId: viewId),
          ),

          // 🔘 FOOTER ACTION
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recommended for you based on your activity. 4.8 ★★★★★ (2M+ Downloads)",
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),

                // Big Action Button
                InkWell(
                  onTap: () => html.window.open(directLink, '_blank'),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF5FF), // Facebook Light Blue
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        btnText,
                        style: const TextStyle(
                          color: Color(0xFF0064E0), // Facebook Dark Blue
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}