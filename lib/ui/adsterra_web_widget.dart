import 'dart:html' as html;
import 'dart:ui_web' as ui_web; // নতুন ভার্সনের জন্য এই ইমপোর্টটি জরুরি
import 'package:flutter/material.dart';

class AdsterraWebWidget extends StatefulWidget {
  final String viewID;
  final String htmlContent;
  final double width;
  final double height;

  const AdsterraWebWidget({
    super.key,
    required this.viewID,
    required this.htmlContent,
    required this.width,
    required this.height,
  });



  @override
  State<AdsterraWebWidget> createState() => _AdsterraWebWidgetState();
}

class _AdsterraWebWidgetState extends State<AdsterraWebWidget> {
  @override
  void initState() {
    super.initState();
    _registerAdFactory();
  }

  void _registerAdFactory() {
    // এখানে ui_web ব্যবহার করা হয়েছে যা নতুন ফ্লাটার ভার্সনে কাজ করে
    ui_web.platformViewRegistry.registerViewFactory(
      widget.viewID,
          (int viewId) {
        final iframe = html.IFrameElement()
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.border = 'none'
          ..srcdoc = widget.htmlContent;
        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: widget.viewID),
    );
  }
}