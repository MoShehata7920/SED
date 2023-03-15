import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/resources/language_manager.dart';

import 'app/app.dart';

void main() async {
  //* DOES DART HAVE GARBAGE COLLECTOR TO FREE MEMORY ?
  //* IF NOT THEN DOES THE MEMORY BEING FREED AT ALL ?
  //* DO WE LEAK MEMORY ?
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [arabicLocal, englishLocal],
      path: assetPathLocalization,
      child: Phoenix(child: MyApp())));
}
