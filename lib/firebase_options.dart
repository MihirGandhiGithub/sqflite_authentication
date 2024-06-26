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
    apiKey: 'AIzaSyBypTGGDxYN9kDATEco2NSMLHsfRsjXyrc',
    appId: '1:625365097680:web:130105795bf563a3a012d5',
    messagingSenderId: '625365097680',
    projectId: 'textile-calculator-80988',
    authDomain: 'textile-calculator-80988.firebaseapp.com',
    databaseURL: 'https://textile-calculator-80988-default-rtdb.firebaseio.com',
    storageBucket: 'textile-calculator-80988.appspot.com',
    measurementId: 'G-01R92KRRP4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASm9FD7i4h_2JzizLY_k4xfEmXMecU6H8',
    appId: '1:625365097680:android:cf1a2a60cc8dd3e9a012d5',
    messagingSenderId: '625365097680',
    projectId: 'textile-calculator-80988',
    databaseURL: 'https://textile-calculator-80988-default-rtdb.firebaseio.com',
    storageBucket: 'textile-calculator-80988.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCBIHuCXZ2afu8vmG2oX-aQmPkarceZxQ',
    appId: '1:625365097680:ios:9438483634bf2ed9a012d5',
    messagingSenderId: '625365097680',
    projectId: 'textile-calculator-80988',
    databaseURL: 'https://textile-calculator-80988-default-rtdb.firebaseio.com',
    storageBucket: 'textile-calculator-80988.appspot.com',
    androidClientId: '625365097680-d6pf7625k7dg0jqscsabeucsq242ugrs.apps.googleusercontent.com',
    iosClientId: '625365097680-81sr2p6m2kfq9kgeg1aicp19oh0tqvd5.apps.googleusercontent.com',
    iosBundleId: 'mg.kingtechnology.in.kt1TextileCalculation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCBIHuCXZ2afu8vmG2oX-aQmPkarceZxQ',
    appId: '1:625365097680:ios:9438483634bf2ed9a012d5',
    messagingSenderId: '625365097680',
    projectId: 'textile-calculator-80988',
    databaseURL: 'https://textile-calculator-80988-default-rtdb.firebaseio.com',
    storageBucket: 'textile-calculator-80988.appspot.com',
    androidClientId: '625365097680-d6pf7625k7dg0jqscsabeucsq242ugrs.apps.googleusercontent.com',
    iosClientId: '625365097680-81sr2p6m2kfq9kgeg1aicp19oh0tqvd5.apps.googleusercontent.com',
    iosBundleId: 'mg.kingtechnology.in.kt1TextileCalculation',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBypTGGDxYN9kDATEco2NSMLHsfRsjXyrc',
    appId: '1:625365097680:web:5ad908764db22be9a012d5',
    messagingSenderId: '625365097680',
    projectId: 'textile-calculator-80988',
    authDomain: 'textile-calculator-80988.firebaseapp.com',
    databaseURL: 'https://textile-calculator-80988-default-rtdb.firebaseio.com',
    storageBucket: 'textile-calculator-80988.appspot.com',
    measurementId: 'G-FJ514JV3RC',
  );

}