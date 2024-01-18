import 'package:abc_banking/Styling/appColors.dart';
import 'package:flutter/material.dart';

class Styling{
  static var smallTextLight = TextStyle(
      color: AppColors.primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w500);
  static var smallTextDark = TextStyle(
      color: AppColors.primaryDarken,
      fontSize: 12,
      fontWeight: FontWeight.w500);

  static var mediumTextLight = TextStyle(
      color: AppColors.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w500);
  static var mediumTextDark = TextStyle(
      color: AppColors.primaryDarken,
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static var largeTextLight = TextStyle(
      color: AppColors.primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static var largeTextDark = TextStyle(
      color: AppColors.primaryDarken,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static var normalTextLight = const TextStyle(
      color:  Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500);
  static var normalTextDark = TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static var normalTextBold = TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static var appbarTitle = TextStyle(
      color: AppColors.textColor,
      fontSize: 20,
      fontWeight: FontWeight.w700);

  static var normalTextMessage = TextStyle(
      color: AppColors.hintColor,
      fontSize: 18,
      fontWeight: FontWeight.w500);


  static var smallLabel = TextStyle(
      color: AppColors.greyDarken8,
      fontSize: 10,
      fontWeight: FontWeight.w500);
  static var largeWarningLabel = TextStyle(
      color: AppColors.warningColor,
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static var largeSuccessLabel = TextStyle(
      color: AppColors.primaryDarken,
      fontSize: 20,
      fontWeight: FontWeight.bold);
}