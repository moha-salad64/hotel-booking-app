import 'package:flutter/material.dart';
// import 'package:hotel_booking_app/components/create_user.dart';
import 'components/Onboarding.dart';
// import 'components/Onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Playfair Display',
      ),
      home: const OnboardingScreen(),
      // home: const CreateUser(),
    );
  }
}

