// * why don't we just use app strings ?
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class Constants {
  //dio constants
  static const String baseUrl = "http://47.243.7.214:3000";

  //mapper constants
  static const String empty = "";
  static const int zero = 0;

  //api constants
  static String token = "SEND TOKEN HERE";
  static String? userId;

  static const int apiTimeOut = 60000;
  static io.Socket socket = io.io('http://47.243.7.214:3000',
      OptionBuilder().setTransports(['websocket']).build());
}
