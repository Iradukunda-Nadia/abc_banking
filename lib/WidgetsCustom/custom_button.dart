import 'package:abc_banking/Styling/appColors.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String buttonText;
  final bool? disabled;
  final Function () onPressed;
  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.disabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: disabled == true?null:onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: disabled == true? MaterialStateProperty.all<Color>
            (AppColors.greylighten1):
          MaterialStateProperty.all<Color>(AppColors.primaryDarken),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
              ))
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
          fontSize: 16
        ),)
    );
  }
}
