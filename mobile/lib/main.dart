import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';

import 'app/app.dart';

void main() async {
  //* DOES DART HAVE GARBAGE COLLECTOR TO FREE MEMORY ?
  //* IF NOT THEN DOES THE MEMORY BEING FREED AT ALL ?
  //* DO WE LEAK MEMORY ?
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
