import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData buttonIcon;
  final VoidCallback onTap;
  final String text;
  const CircleButton({
    Key? key,
    required this.buttonIcon,
    required this.onTap,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.1),
                radius: 30,
                child: Icon(
                  buttonIcon,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),

        Text(text, style: Styling.smallTextLight,)
      ],
    );
  }
}
