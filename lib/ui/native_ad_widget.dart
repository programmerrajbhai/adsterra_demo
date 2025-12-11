// lib/ui/ad_widgets/native_ad_widget.dart
import 'package:flutter/material.dart';
import 'package:adsterra_demo/ui/adsterra_web_widget.dart';
import 'package:adsterra_demo/ui/adsterra_config.dart';

class NativeAdWidget extends StatelessWidget {
  final double width;
  final double height;
  final String viewId;

  const NativeAdWidget({
    super.key,
    this.width = 350,
    this.height = 300,
    this.viewId = 'native-ad-view',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // height can be flexible; many native units are responsive inside iframes
      constraints: BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: AdsterraWebWidget(
        viewID: viewId,
        width: width,
        height: height,
        htmlContent: AdsterraConfig.getNativeAdHtml(),
      ),
    );
  }
}
