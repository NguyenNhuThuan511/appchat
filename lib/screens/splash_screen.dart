// import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:appchat/api/apis.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

// splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const  SystemUiOverlayStyle(systemNavigationBarColor: Colors.white, statusBarColor: Colors.white));

        if(APIs.auth.currentUser != null ){
          log('\nUser: ${APIs.auth.currentUser}');
          
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        }else{
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        } 
    });
  }
  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //     automaticallyImplyLeading: false,
      //     //leading: const Icon(CupertinoIcons.home),
      //     title: const Text('Welcome to AppChat'),
          
      //   ),
        body: Stack(children: [
          Positioned(
            top: mq.height * .15,
            right:  mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('images/icon.png')),

          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Text('MADE VN ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, color: Colors.black87, letterSpacing: .5,
              ),
            )),
          ]),
    );
  }
}

// hết 10 tới 11.FullScreen Mode & Fixed (Portrait) Orientation (Android + iOS) In Flutter App | Chatting App