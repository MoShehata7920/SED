import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/resources/language_manager.dart';
import 'package:sed/testpush.dart';
import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  //* DOES DART HAVE GARBAGE COLLECTOR TO FREE MEMORY ?
  //* IF NOT THEN DOES THE MEMORY BEING FREED AT ALL ?
  //* DO WE LEAK MEMORY ?
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await initAppModule();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final PushNotificationService pushNotificationService =
      PushNotificationService();
  await pushNotificationService.initialize();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print('Device Token: $token');
  
  runApp(EasyLocalization(
      supportedLocales: const [arabicLocal, englishLocal],
      path: assetPathLocalization,
      child: Phoenix(child: MyApp())));
}
