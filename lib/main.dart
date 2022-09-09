import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login01/constants/data_uploader_screen.dart';
import 'package:login01/firebase_options.dart';
import 'package:login01/screens/auth-screen.dart';
import 'package:login01/screens/overview_screen.dart';
import 'package:login01/screens/splash_screen.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home:DataUploaderCcreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Relaway',
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return const OverviewScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}
