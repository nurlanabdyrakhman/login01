import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.yellow,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/image/app_splash_logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
