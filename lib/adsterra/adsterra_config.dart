class AdsterraConfig {
  // ==========================================
  // 🔑 AD KEYS
  // ==========================================

  // আপনার দেওয়া ব্যানার কি (Banner Key)
  static const String bannerKey = "9964ceedd636bc71ee33b5cde8683614";

  // ==========================================
  // 🛠️ HTML GENERATORS
  // ==========================================

  /// ১. ব্যানার অ্যাড (Banner Ad) জেনারেটর
  static String getBannerHtml({required int width, required int height}) {
    return '''
      <html>
        <body style="margin:0;padding:0;overflow:hidden;display:flex;justify-content:center;align-items:center;">
          <script type="text/javascript">
            atOptions = {
              'key' : '$bannerKey',
              'format' : 'iframe',
              'height' : $height,
              'width' : $width,
              'params' : {}
            };
          </script>
          <script type="text/javascript" src="//www.highperformancedformats.com/$bannerKey/invoke.js"></script>
        </body>
      </html>
    ''';
  }

  /// ২. নেটিভ অ্যাড (Native Ad) জেনারেটর
  /// আপনার দেওয়া স্ক্রিপ্ট এখানে বসানো হয়েছে
  static String getNativeAdHtml() {
    return '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
        </head>
        <body style="margin:0;padding:0;overflow:hidden;background-color:transparent;">
          
          <script async="async" data-cfasync="false" src="//pl25493353.effectivegatecpm.com/8e8a276d393bb819af043954cc38995b/invoke.js"></script>
          <div id="container-8e8a276d393bb819af043954cc38995b"></div>
          </body>
      </html>
    ''';
  }
}