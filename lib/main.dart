import 'package:flutter/material.dart';
import 'components/main_screen.dart';
import 'components/Onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnboarded = prefs.getBool('isOnboarded') ?? false;
  return runApp( MyApp(isOnboarded: isOnboarded));
}

class MyApp extends StatelessWidget {
  final bool isOnboarded;
  const MyApp({key , required this.isOnboarded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Playfair Display',
      ),
    
      home:  isOnboarded ? MainScreen() : OnboardingScreen() ,    
      );
  }
}

