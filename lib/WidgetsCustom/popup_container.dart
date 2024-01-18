import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/WidgetsCustom/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs{
  static Future<void> showAlertDialog(
      BuildContext context,
      type,
      content,
      okPressed()) {

    // set up the button
    Widget okButton = CustomButton(
      disabled: false,
      buttonText: "Done",
      onPressed: () {
        okPressed();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: type =="success"? Padding(
        padding: const EdgeInsets.only(top: 15.0,bottom: 20),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryDarken,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.checkmark,
                color: AppColors.brightWhite,
                size: 40,
              ),
            )
        ),
      ):
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 20),
        child: CircleAvatar(
          radius: 30,
            backgroundColor: AppColors.warningColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.clear,
                color: AppColors.primaryColor,
                size: 40,
              ),
            )
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,

      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          type =="success"? Text("completed successfully 🎉 " ,
            style: Styling.appbarTitle, textAlign: TextAlign.center,):
          Text("Unfortunately something went wrong ☹️. "
              "please try again. ", style: Styling.appbarTitle, textAlign: TextAlign.center,),
          const SizedBox(height: 20),
          content != ''? Text(
            content, style: Styling.normalTextBold,
          ): SizedBox(height: 0, ),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}