import 'package:adsterra_demo/ui/adsterra_config.dart';
import 'package:adsterra_demo/ui/adsterra_web_widget.dart';
import 'package:adsterra_demo/ui/banner_ad_widget.dart';
import 'package:adsterra_demo/ui/native_ad_widget.dart';
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
      home: const HomePage(),
    );
  }
}

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


            /*
// Banner section
            const Text("Banner Ad (300x250)", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            const BannerAdWidget(width: 300, height: 250),

            const SizedBox(height: 40),

             */

// Native section
            const Text("Native Ad (Your Code)", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            const NativeAdWidget(width: 350, height: 300),
          ],
        ),
      ),
    );
  }
}