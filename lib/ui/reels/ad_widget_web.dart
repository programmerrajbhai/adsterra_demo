// lib/ui/reels/ad_widget_web.dart
// ignore_for_file: uri_does_not_exist

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:js_util' as js_util;

class NativeAdWidget extends StatefulWidget {
  final String viewId;
  final double height;
  final double width;

  const NativeAdWidget({
    Key? key,
    required this.viewId,
    this.height = 90,
    this.width = 728,
  }) : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  bool _registered = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb && !_registered) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(widget.viewId, (int viewId) {
        final container = html.DivElement()
          ..id = widget.viewId
          ..style.width = '100%'
          ..style.height = '${widget.height}px'
          ..style.display = 'block'
          ..style.overflow = 'hidden';

        // placeholder while loading
        final placeholder = html.DivElement()
          ..text = 'Advertisement'
          ..style.width = '100%'
          ..style.height = '${widget.height}px'
          ..style.display = 'flex'
          ..style.alignItems = 'center'
          ..style.justifyContent = 'center'
          ..style.background = '#f5f5f5'
          ..style.color = '#888';
        container.append(placeholder);

        // Inject atOptions and loader script specific to this container
        try {
          // Create options script element
          final optionsScript = html.ScriptElement()
            ..type = 'text/javascript'
            ..text = """
              var atOptions = {
                'key' : '8e8a276d393bb819af043954cc38995b',
                'format' : 'iframe',
                'height' : ${widget.height},
                'width' : '100%',
                'params' : {}
              };
            """;

          // Create loader script element (use https if available)
          final loaderScript = html.ScriptElement()
            ..async = true
            ..setAttribute('data-cfasync', 'false')
            ..src = 'https://pl25493353.effectivegatecpm.com/8e8a276d393bb819af043954cc38995b/invoke.js';

          // Append scripts to container so ad network can inject iframe inside this container
          container.append(optionsScript);
          container.append(loaderScript);

          // Mark injected to avoid duplicates
          container.dataset['injected'] = '1';
        } catch (e) {
          // fallback: append a simple iframe placeholder
          if (container.dataset['injected'] != '1') {
            final iframe = html.IFrameElement()
              ..width = '100%'
              ..height = '${widget.height}'
              ..style.border = '0';
            container.append(iframe);
            container.dataset['injected'] = '1';
          }
        }

        // Also call global lazy loader if present (keeps compatibility)
        Future.delayed(const Duration(milliseconds: 50), () {
          try {
            final fn = js_util.getProperty(html.window, '_registerNativeAdLazyLoader');
            if (fn != null) {
              js_util.callMethod(fn, 'call', [html.window, widget.viewId, widget.width, widget.height]);
            }
          } catch (_) {}
        });

        return container;
      });
      _registered = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: HtmlElementView(viewType: widget.viewId),
    );
  }
}
