// lib/ui/ad_widgets/banner_ad_widget.dart
import 'package:flutter/material.dart';
import 'package:adsterra_demo/ui/adsterra_web_widget.dart';
import 'package:adsterra_demo/ui/adsterra_config.dart';

class BannerAdWidget extends StatelessWidget {
  final double width;
  final double height;
  final String viewId;

  const BannerAdWidget({
    super.key,
    this.width = 300,
    this.height = 250,
    this.viewId = 'banner-ad-view',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: AdsterraWebWidget(
        viewID: viewId,
        width: width,
        height: height,
        htmlContent: AdsterraConfig.getBannerHtml(
          width: width.toInt(),
          height: height.toInt(),
        ),
      ),
    );
  }
}
