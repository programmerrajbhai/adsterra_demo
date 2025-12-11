// lib/ui/reels/ad_widget_mobile.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NativeAdWidget extends StatefulWidget {
  final String htmlContent;
  final double height;

  const NativeAdWidget({
    super.key,
    required this.htmlContent,
    this.height = 90,
  });

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  late final WebViewController _controller;
  bool _controllerInitialized = false;

  @override
  void initState() {
    super.initState();

    // For Android, you can optionally set the platform implementation.
    // WebView.platform = AndroidWebView(); // usually not required with latest plugin

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));

    // Load the HTML content as a data URL
    final initialUrl = Uri.dataFromString(
      widget.htmlContent,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    );

    _controller.loadRequest(initialUrl);

    _controllerInitialized = true;
  }

  @override
  void dispose() {
    // No explicit dispose required for WebViewController currently,
    // but if you add listeners, remove them here.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controllerInitialized) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: widget.height,
      child: WebViewWidget(controller: _controller),
    );
  }
}
