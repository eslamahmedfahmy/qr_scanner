import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_scanner/qr_view_example.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String logo = "assets/images/splash_logo.svg";
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const QRViewExample()),
            (route) => false);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.teal,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(logo, height: 150),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "QR Code Sanner",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}