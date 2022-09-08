import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login01/constants/app_con.dart';
import 'package:login01/screens/auth-screen.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultTextStyle(
              style:AppCon.HeightButtonTxtStyle ,
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText("Congrats!"),
                  WavyAnimatedText('Well Done!'),
                ],
                isRepeatingAnimation: false,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            DefaultTextStyle(
              style:AppCon.HeightButtonTxtStyle.copyWith(fontSize: 20),
              child: AnimatedTextKit(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthScreen()),
                    );
                  });
                },
                animatedTexts: [
                  TyperAnimatedText(
                    'Log out',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}