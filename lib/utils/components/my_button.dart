import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/utils/constants/colors.dart';

class MyButton extends StatelessWidget {
  String title;
  VoidCallback onTap;

  bool loading;
  MyButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        height: height * 0.0575,
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
