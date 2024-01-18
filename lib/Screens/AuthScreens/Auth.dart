import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/ATM/atm_login.dart';
import 'package:abc_banking/Screens/AuthScreens/Login.dart';
import 'package:abc_banking/Screens/ATM/atmHome.dart';
import 'package:abc_banking/Screens/Mobile/Home.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/WidgetsCustom/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart' hide PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  Auth({super.key});

  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: "44",
      countryCode: "UK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "United Kingdom",
      example: "UK",
      displayName: "UK",
      displayNameNoCountryCode: "UK",
      e164Key: "");
  bool hasAccount = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AtProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color(0xffF2F7EC),
        body: kIsWeb
            ? const AtmLogin()
            :!auth.isSignedIn
            ? const LoginScreen()
            : const HomePage());
  }
}
