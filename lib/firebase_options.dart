// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCKC7yFMWkrcc96qISj1mwx1OO-kM45iKY',
    appId: '1:185379516250:web:3bd62a8d5dec860f164d63',
    messagingSenderId: '185379516250',
    projectId: 'abc-b0b7f',
    authDomain: 'abc-b0b7f.firebaseapp.com',
    storageBucket: 'abc-b0b7f.appspot.com',
    measurementId: 'G-E55BM9HEQX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBP2YZEG7RZPQ4OAaW92E1ABsiEQDwtc2s',
    appId: '1:185379516250:android:aeb806017d2c1a6c164d63',
    messagingSenderId: '185379516250',
    projectId: 'abc-b0b7f',
    storageBucket: 'abc-b0b7f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQW7jJ8yavMFeX1KGy2zIdEZcck2FoqsY',
    appId: '1:185379516250:ios:89ca4d98151af14c164d63',
    messagingSenderId: '185379516250',
    projectId: 'abc-b0b7f',
    storageBucket: 'abc-b0b7f.appspot.com',
    iosBundleId: 'com.example.abcBanking',
  );
}
