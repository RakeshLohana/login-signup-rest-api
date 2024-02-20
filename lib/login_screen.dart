import 'package:flutter/material.dart';
import 'package:flutter_api_integration/controller.dart';
import 'package:flutter_api_integration/custom_button.dart';
import 'package:flutter_api_integration/custom_textField.dart';
import 'package:flutter_api_integration/custom_text_widget.dart';
import 'package:flutter_api_integration/register_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController =
        Get.put(AuthenticationController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomTextWidget(
          text: "Login Screeen",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CustomTextField(
              controller: authenticationController.email, labelText: "Email"),
          SizedBox(
            height: context.height * 0.02,
          ),
          CustomTextField(
              controller: authenticationController.password,
              labelText: "Passsword"),
          SizedBox(
            height: context.height * 0.02,
          ),
          CustomButton(
            ontap: () {
              authenticationController.login();
            },
            text: 'Login',
          ),
          TextButton(
              onPressed: () {
                Get.to(RegistrationScreen());
              },
              child: CustomTextWidget(text: 'Go to signup'))
        ]),
      ),
    );
  }
}
