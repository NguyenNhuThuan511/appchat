// import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'dart:io';

import 'package:appchat/api/apis.dart';

import '../home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../helper/dialogs.dart';
import '../../main.dart';  
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), (){
      setState(() =>  _isAnimate = true);
    });
  }

  _handleGoogleBtnClick(){
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');


        if((await  APIs.userExists())) {
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));

        }else{
          await APIs.createUser().then((value){
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          });
        }

        
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = 
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await APIs.auth.signInWithCredential(credential);
    }catch (e){
      log('\n_signInWithGoogle: $e');
      //Dialogs.showSnackbar(context, 'Something went wrong (Check Internet!)');
      Dialogs.showSnackbar(context, 'Something went wrong (Check Internet!)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    //mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          //leading: const Icon(CupertinoIcons.home),
          title: const Text('Welcome to AppChat'),
          
        ),
        body: Stack(children: [
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: const Duration(seconds: 1),
            child: Image.asset('images/icon.png')),

          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .07,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 223, 255, 187), 
                shape: const StadiumBorder(),
                elevation: 1),
              onPressed: () {
                _handleGoogleBtnClick();
                // Navigator.pushReplacement(context, 
                //   MaterialPageRoute(builder: (_) => const HomeScreen()));
              },

              icon: Image.asset('images/google.png', height: mq.height * .03),
              
              
              label: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: 'Login with '),
                    TextSpan(
                      text: 'Google',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  ]),
              ))),
          ]),
    );
  }
}