import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:netflixappassignment/Networks/app_exception.dart';
import 'package:netflixappassignment/Networks/networksapi.dart';

class Networkapi extends Baseapiservice {
  @override
  Future<dynamic> getapi(String url) async {
    dynamic responsejson;
    try {
      if (kDebugMode) {
        print("Request URL: $url");
      }
      final response = await http
          .get(
            Uri.parse(url)
          )
          .timeout(const Duration(seconds: 30));

      responsejson = returnResponse(response);
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket Exception occurred: $e');
      }
      throw Internetexeption('No internet connection');
    } on TimeoutException {
      throw Requesttimeout('Request Timeout please try again');
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      // Handle any other exceptions here
    }
    return responsejson;
  }
  
// handle response json
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responsejson = jsonDecode(response.body);
        return responsejson;
      case 400:
        throw Invalidurlexeption('Invalid URL');
      case 500:
      default:
        throw Servereception('Server error');
    }
  }

}