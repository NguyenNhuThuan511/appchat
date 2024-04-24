// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxNokAg4Xttj286MK_RekxgkwZNK3jPlU',
    appId: '1:228584656440:android:07dfa2c7a14cf687a260cd',
    messagingSenderId: '228584656440',
    projectId: 'app-chat-413da',
    storageBucket: 'app-chat-413da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjAJ43heUL0rpqF65IwAsIgg0amgf5NcY',
    appId: '1:228584656440:ios:ccd090d57a1a8bdda260cd',
    messagingSenderId: '228584656440',
    projectId: 'app-chat-413da',
    storageBucket: 'app-chat-413da.appspot.com',
    androidClientId: '228584656440-a6ermph59hiovqhg4q14pn30qpleta55.apps.googleusercontent.com',
    iosClientId: '228584656440-o5pvt6khvs37ok6089bn4gduccuel8lk.apps.googleusercontent.com',
    iosBundleId: 'com.example.appchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjAJ43heUL0rpqF65IwAsIgg0amgf5NcY',
    appId: '1:228584656440:ios:ccd090d57a1a8bdda260cd',
    messagingSenderId: '228584656440',
    projectId: 'app-chat-413da',
    storageBucket: 'app-chat-413da.appspot.com',
    iosBundleId: 'com.example.appchat',
  );
}