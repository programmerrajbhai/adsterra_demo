
import 'package:adsterra_demo/ui/reels/reel_screens.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const AdsterraDemoApp());
}

class AdsterraDemoApp extends StatelessWidget {
  const AdsterraDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adsterra Web App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const ReelScreens(),
    );
  }
}


/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meetyarah Web Ads"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Card
            const Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Welcome to Adsterra Integration Demo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- BANNER AD SECTION ---
            const Text("Banner Ad (300x250)", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: AdsterraWebWidget(
                viewID: 'banner-ad-view',
                width: 300,
                height: 250,
                htmlContent: AdsterraConfig.getBannerHtml(width: 300, height: 250),
              ),
            ),

            const SizedBox(height: 40),

            // --- NATIVE AD SECTION ---
            const Text("Native Ad (Your Code)", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AdsterraWebWidget(
                viewID: 'native-ad-view',
                width: 350,
                height: 300, // স্ক্রিপ্ট লোড হওয়ার জন্য জায়গা
                htmlContent: AdsterraConfig.getNativeAdHtml(),
              ),
            ),

            const SizedBox(height: 50),
            const Text("Scroll down for more content..."),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

 */