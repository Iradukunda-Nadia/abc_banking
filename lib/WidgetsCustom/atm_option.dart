import 'package:abc_banking/Styling/appColors.dart';
import 'package:flutter/material.dart';


class AtmOption extends StatelessWidget {
  final bool isRight;
  final String title;
  final Function()? onTap;
  const AtmOption({Key? key,
    required this.isRight,
    required this.title,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: isRight? const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5)
            ): const BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5)
            ),
            color: AppColors.primaryColor,
            border: isRight? Border(
                right: BorderSide(
                    width: 40,
                    color: AppColors.primaryDarken.withOpacity
                      (0.7)
                ),
            ): Border(
              left: BorderSide(
                  width: 40,
                  color: AppColors.primaryDarken.withOpacity
                    (0.7)
              ),
            )

        ),
        child: Center(child: Text(title, style:
        TextStyle(color: AppColors.primaryDarken,fontWeight:
        FontWeight.bold, fontSize: 20),)),
      ),
    );
  }
}
