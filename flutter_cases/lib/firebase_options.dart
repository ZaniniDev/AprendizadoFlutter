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
    apiKey: 'AIzaSyAWrL9GsKnGLUqWng8_M0CB057BUDlkYko',
    appId: '1:481867099935:web:65bf5250fe869c78bc4a2a',
    messagingSenderId: '481867099935',
    projectId: 'financas-app-test',
    authDomain: 'financas-app-test.firebaseapp.com',
    storageBucket: 'financas-app-test.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD82gELRDzky9_JvOlHSc5kd8jPLG7mywQ',
    appId: '1:481867099935:android:61dd85956b42193dbc4a2a',
    messagingSenderId: '481867099935',
    projectId: 'financas-app-test',
    storageBucket: 'financas-app-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCe1OevogKqLv8U9thf8RIfNGvhnrmBX_Q',
    appId: '1:481867099935:ios:6a2ae99819ca3898bc4a2a',
    messagingSenderId: '481867099935',
    projectId: 'financas-app-test',
    storageBucket: 'financas-app-test.appspot.com',
    iosClientId: '481867099935-8a4ueui53f0c93a8ap3gb2fiv0276h62.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterCases',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCe1OevogKqLv8U9thf8RIfNGvhnrmBX_Q',
    appId: '1:481867099935:ios:6a2ae99819ca3898bc4a2a',
    messagingSenderId: '481867099935',
    projectId: 'financas-app-test',
    storageBucket: 'financas-app-test.appspot.com',
    iosClientId: '481867099935-8a4ueui53f0c93a8ap3gb2fiv0276h62.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterCases',
  );
}
