import 'package:flutter/material.dart';
import 'package:flutter_api_integration/controller.dart';
import 'package:flutter_api_integration/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await _prefs;
            prefs.remove("savedToken").then((value) {
              Get.offAll(LoginScreen());
            });
            print(prefs.getString("savedToken"));
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
