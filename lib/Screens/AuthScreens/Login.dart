import 'package:abc_banking/Screens/AuthScreens/NewUser.dart';
import 'package:abc_banking/Services/authService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/WidgetsCustom/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: "44",
      countryCode: "GB",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "United Kingdom",
      example: "United Kingdom",
      displayName: "United Kingdom (GB)",
      displayNameNoCountryCode: "GB",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection =TextSelection.fromPosition(TextPosition
      (offset: phoneController.text.length));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 70,
          ),
          Image.asset(
            'assets/images/abcLogoNew.png',
            width: 270,
            height: 270,
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              child: Column(
                children: [
                  Text('Sign in', textAlign:TextAlign.left,
                    style: TextStyle(
                      fontSize:30,
                      color: AppColors.textColor,
                    ),),
                  const SizedBox(height: 10),
                  Text("Enter your phone number below and we'll send "
                      "you a verification code",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.subTitleColor,
                    ),),
                  const SizedBox(height: 20),
                  TextFormField(
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    controller: phoneController,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                    cursorColor: AppColors.primaryDarken,
                    decoration: InputDecoration(
                        hintText: "Enter Phone number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.greylighten1
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: AppColors.greylighten1
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: AppColors.greylighten1
                            )
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            onTap: (){
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 550,
                                  ),
                                  onSelect: (value){
                                    setState((){
                                      selectedCountry = value;
                                    });
                                  });
                            },
                            child: Text("${selectedCountry.flagEmoji} +"
                                " ${selectedCountry.phoneCode}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color:AppColors.textColor,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                        suffixIcon: phoneController.text.length>9?
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryDarken
                            ),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ):
                        phoneController.text.isNotEmpty? Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: GestureDetector(
                            onTap: (){
                              phoneController.clear();
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor
                              ),
                              child: Icon(
                                CupertinoIcons.clear,
                                color: AppColors.textColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ):
                        null
                    ),
                    onChanged: (val){
                      setState(() {
                        phoneController.text = val;
                      });

                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      disabled: false,
                      onPressed: (){
                        AuthService().sendPhoneNumber(
                            context,
                            "+${selectedCountry.phoneCode}"
                                "${phoneController.text.trim()}",
                          null
                        );
                      },
                      buttonText: 'Sign in',
                    ),
                  ),

                  const SizedBox(height: 20),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: "Don't have an account yet? \n",
                          style: TextStyle
                            (fontSize: 14, color: AppColors.textColor),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(builder:
                                    (context)=> const NewUser()));
                          },
                          text: "Sign up here.",
                          style: TextStyle
                            (fontSize: 16, fontWeight: FontWeight.bold, color:
                          AppColors.primaryDarken),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
