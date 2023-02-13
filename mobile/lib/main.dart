import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  //FIXME DOES DART HAVE GARBAGE COLLECTOR TO FREE MEMORY ?
  //FIXME IF NOT THEN DOES THE MEMORY BEING FREED AT ALL ?
  //FIXME DO WE LEAK MEMORY ?
  runApp(MyApp());
}
