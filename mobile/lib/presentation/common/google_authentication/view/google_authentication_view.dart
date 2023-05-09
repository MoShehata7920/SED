// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';

import '../../../../app/constants.dart';

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'profile',
  'https://www.googleapis.com/auth/userinfo.email',
  'https://www.googleapis.com/auth/userinfo.profile',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
    serverClientId:
        "602406913114-n0ekltbq1095rnr9fm6rnd55vb3eo25p.apps.googleusercontent.com");



/// The SignInDemo app.
class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        // _handleGetContact(account!);
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    //_googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(String serverAuthToken) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    const String apiUrl = 'http://sed.zapto.org:3000/auth/google/redirect';
    final Map<String, String> queryParams = {
      'code': serverAuthToken,
      'scope':
          'email profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile openid',
      'authuser': '0',
      'prompt': 'consent',
    };
    final String queryString = Uri(queryParameters: queryParams).query;
    final String requestUrl = '$apiUrl?$queryString';

    final http.Response response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'Server returned a ${response.statusCode} '
            'response. Check logs for details.';
        print(_contactText);
      });
      print(
          'Server returned a ${response.statusCode} response: ${response.body}');
      return;
    }

    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    final User user = User.fromJson(responseBody['User']);
    final String token = responseBody['token'];

    Constants.token = token;
    //Constants.user = user;

    Navigator.pushReplacementNamed(context, Routes.mainScreenRoute);
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
      String? serverAuthToken = googleUser.serverAuthCode;

      await _handleGetContact(serverAuthToken ?? "");
      print(serverAuthToken);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    return IconButton(
      color: ColorsManager.grayIcon,
      onPressed: () async {
        await _handleSignIn();
      },
      icon: const FaIcon(IconsManager.google),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
