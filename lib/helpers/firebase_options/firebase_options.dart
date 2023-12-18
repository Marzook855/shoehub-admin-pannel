import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
// i0S and MacOS
      return const FirebaseOptions(
        appId: '1:941871089491:ios:c06220ea81450c3e9203a6',
        apiKey: 'AIzaSyBpx4FJj-c-MOlXJYZO4BX2vZSgL6_DR9Y',
        projectId: 'shoe-hub-fd434',
        messagingSenderId: '941871089491',
        iosBundleId: 'com.example.adminpanel',
      );
    } else {
//Android
      return const FirebaseOptions(
        appId: '1:941871089491:android:cc58428bbfeab7379203a6',
        apiKey: 'AIzaSyBTDbjTvNx3D2ycVtObDH8ezuxMsf8RcTA',
        projectId: 'shoe-hub-fd434',
        messagingSenderId: '941871089491',
        storageBucket: "gs://shoe-hub-fd434.appspot.com",
      );
    }
  }
}
