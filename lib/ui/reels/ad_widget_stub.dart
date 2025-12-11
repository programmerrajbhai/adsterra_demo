// lib/ui/reels/ad_widget_stub.dart
import 'package:flutter/material.dart';

class NativeAdWidget extends StatelessWidget {
  final String viewId;
  final double height;
  final double width;
  final String htmlContent;

  const NativeAdWidget({Key? key, this.viewId = '', this.height = 90, this.width = 728, this.htmlContent = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.grey[200],
      child: const Center(child: Text('Advertisement')),
    );
  }
}
