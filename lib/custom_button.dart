import 'package:flutter/material.dart';
import 'package:flutter_api_integration/custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? ontap;
  const CustomButton({
    super.key,
    required this.text,
        this.ontap,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.purple,
        ),
        child: Center(
            child: CustomTextWidget(
          text: text,
          textColor: Colors.white,
          fontSize: 14,
        )),
      ),
    );
  }
}
