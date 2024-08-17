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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAKqNxFtVYKJlr-JAk0NLR_aJpz4U4dL_k',
    appId: '1:103042254071:web:a74c8a67c2146e34a8fff2',
    messagingSenderId: '103042254071',
    projectId: 'coseticlogin',
    authDomain: 'coseticlogin.firebaseapp.com',
    storageBucket: 'coseticlogin.appspot.com',
    measurementId: 'G-6ERW3VBPTN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeMT6Q1qa-krYZmg2tCthChTH6LoCgZU4',
    appId: '1:103042254071:android:7fbd9c18a835d31aa8fff2',
    messagingSenderId: '103042254071',
    projectId: 'coseticlogin',
    storageBucket: 'coseticlogin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZ7zvtLohf5gVxM5UOv5hYP87RVui8lJk',
    appId: '1:103042254071:ios:da53ad219ab94d25a8fff2',
    messagingSenderId: '103042254071',
    projectId: 'coseticlogin',
    storageBucket: 'coseticlogin.appspot.com',
    androidClientId: '103042254071-p31gmn4f6plson8e508bmo4mlhm3boae.apps.googleusercontent.com',
    iosClientId: '103042254071-mv29e0ps3ccmo67ukijhflujgts248h1.apps.googleusercontent.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZ7zvtLohf5gVxM5UOv5hYP87RVui8lJk',
    appId: '1:103042254071:ios:da53ad219ab94d25a8fff2',
    messagingSenderId: '103042254071',
    projectId: 'coseticlogin',
    storageBucket: 'coseticlogin.appspot.com',
    androidClientId: '103042254071-p31gmn4f6plson8e508bmo4mlhm3boae.apps.googleusercontent.com',
    iosClientId: '103042254071-mv29e0ps3ccmo67ukijhflujgts248h1.apps.googleusercontent.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAKqNxFtVYKJlr-JAk0NLR_aJpz4U4dL_k',
    appId: '1:103042254071:web:7240e9a5fa2d95f0a8fff2',
    messagingSenderId: '103042254071',
    projectId: 'coseticlogin',
    authDomain: 'coseticlogin.firebaseapp.com',
    storageBucket: 'coseticlogin.appspot.com',
    measurementId: 'G-H5YENP8DGW',
  );
}
