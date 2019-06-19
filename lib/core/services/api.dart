import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  // BasicSetupServices _basicSetupServices = locator<BasicSetupServices>();

  //var client = new http.Client();

  final JsonDecoder _decoder = new JsonDecoder();

  static final BASE_URL = "https://crio-capstone.appspot.com";
  static final API_VERSION = "/api/v1";

  Future<dynamic> get(String url) {

    String complete_url = BASE_URL + API_VERSION + url;
    // print(complete_url);

    return http.get(complete_url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      // if (statusCode < 200 || statusCode > 400 || json == null) {
      //   throw new Exception("Error while fetching data");
      // }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    String complete_url = BASE_URL + API_VERSION + url;

    return http
        .post(complete_url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      //loginModel.loginRequired = true;

      if (statusCode == 401) {
        //Route route = MaterialPageRoute(builder: (context) => LoginPage());
       // _basicSetupServices.navigatorKey.currentState
       //     .pushAndRemoveUntil(route, (Route<dynamic> route) => false);

        throw new Exception("Error while fetching data");
      }

      return _decoder.convert(res);
    });
  }
}
