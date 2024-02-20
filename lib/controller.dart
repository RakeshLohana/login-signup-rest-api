import 'dart:convert';

import 'package:dio/dio.dart' as dioPackage;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api_integration/base_url.dart';
import 'package:flutter_api_integration/custom_text_widget.dart';
import 'package:flutter_api_integration/home_screen.dart';
import 'package:flutter_api_integration/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    SharedPreferences _prefs = await prefs;
    if (_prefs.getString("savedToken") != "") {
      Get.offAll(HomeScreen());
    } else {
      Get.offAll(LoginScreen());
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  void register() async {
    final dio = dioPackage.Dio();
    try {
      dioPackage.Response response = await dio.post(
          AuthenticationClass.baseUrl + AuthenticationClass.register,
          data: jsonEncode(
            {
              "name": name.text,
              "email": email.text,
              "password": password.text,
            },
          ),
          options: dioPackage.Options(contentType: "application/json"));

      if (response.statusCode == 200) {
        print(response.data);
        if (response.data["code"] == 0) {
          final String token = response.data["data"]["Token"];

          final SharedPreferences _prefs = await prefs;
          _prefs.setString("savedToken", token);
          name.clear();
          email.clear();
          password.clear();
          Get.snackbar("Registration", response.data["message"]);

          Get.offAll(HomeScreen());
        } else {
          GetSnackBar(
            title: "Registration failed",
            message: response.data["message"],
            icon: Icon(Icons.error),
          );
          throw jsonDecode(response.data["message"]) ?? "unknow error occured";
        }
      } else {
        GetSnackBar(
          title: "Registration failed",
          message: response.data["Message"],
          icon: Icon(Icons.error),
        );
        throw jsonDecode(response.data["Message"]) ?? "unknow error occured";
      }
    } catch (e) {
      GetSnackBar(
        title: "An error occured",
        message: e.toString(),
        icon: Icon(Icons.error),
      );

      print(e.toString());
    }
  }

  void login() async {
    Map json = {"email": email.text.trim(), "password": password.text};
    var headers = {"content-Type": "application/json "};
    try {
      http.Response response = await http.post(
          Uri.parse(
            AuthenticationClass.baseUrl + AuthenticationClass.loginEndpoint,
          ),
          body: jsonEncode(json),
          headers: headers);
      print(response.body);
      final jsonDecoding = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (jsonDecoding["code"] == 0) {
          var token = jsonDecoding["data"]["Token"];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("savedToken", token);
          Get.snackbar("Login suceess", jsonDecoding["message"]);
          email.clear();
          password.clear();
          Get.off(HomeScreen());
        } else {
          Get.snackbar("Login Failed", jsonDecoding["message"]);
        }
      } else {
        Get.snackbar("Login Failed", jsonDecoding["Message"]);
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());

      print(e.toString());
    }
  }
}
