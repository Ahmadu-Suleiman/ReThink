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
    apiKey: 'AIzaSyCBaCt4yhMxc-laxbX5tzVBAoJy6ApJDnw',
    appId: '1:370299394465:web:14e1eadd901fc0c3b0d3e0',
    messagingSenderId: '370299394465',
    projectId: 'rethink-2892c',
    authDomain: 'rethink-2892c.firebaseapp.com',
    storageBucket: 'rethink-2892c.appspot.com',
    measurementId: 'G-PK5YF4EN9D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpJfZYJwcrJby92hkcs-uY863r4cRQZv8',
    appId: '1:370299394465:android:4364e807c5770d67b0d3e0',
    messagingSenderId: '370299394465',
    projectId: 'rethink-2892c',
    storageBucket: 'rethink-2892c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8SlcO7zoMdn_5OLPgCN2GiRHODuGIhZg',
    appId: '1:370299394465:ios:c7233a8cfc31c561b0d3e0',
    messagingSenderId: '370299394465',
    projectId: 'rethink-2892c',
    storageBucket: 'rethink-2892c.appspot.com',
    iosBundleId: 'com.meta4projects.rethink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8SlcO7zoMdn_5OLPgCN2GiRHODuGIhZg',
    appId: '1:370299394465:ios:bcce57390f2494feb0d3e0',
    messagingSenderId: '370299394465',
    projectId: 'rethink-2892c',
    storageBucket: 'rethink-2892c.appspot.com',
    iosBundleId: 'com.example.rethink',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCBaCt4yhMxc-laxbX5tzVBAoJy6ApJDnw',
    appId: '1:370299394465:web:d7ca4f63ec749dbdb0d3e0',
    messagingSenderId: '370299394465',
    projectId: 'rethink-2892c',
    authDomain: 'rethink-2892c.firebaseapp.com',
    storageBucket: 'rethink-2892c.appspot.com',
    measurementId: 'G-0YVVHNKWHL',
  );

}