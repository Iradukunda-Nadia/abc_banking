import 'dart:math';

import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/AuthScreens/Auth.dart';
import 'package:abc_banking/Screens/Mobile/Home.dart';
import 'package:abc_banking/Services/authService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/WidgetsCustom/custom_button.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NewUser extends StatefulWidget {
  final bool? fromOTP;
  const NewUser({Key? key,
  this.fromOTP
  }) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {

  final _signUpKey = new GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pinController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

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
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String phone = Provider.of<AtProvider>(context, listen: false)
        .phone?? '';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
            child: Form(
              key: _signUpKey,
              child: Column(
                children: [
                  Text('Registration', textAlign:TextAlign.left,
                    style: TextStyle(
                      fontSize:30,
                      color: AppColors.textColor,
                    ),),
                  const SizedBox(height: 10),
                  Text("Enter your details below to create your new account with "
                      "ABC banking group",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.subTitleColor,
                    ),),
                  const SizedBox(height: 20),
                  //name field
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      controller: nameController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      cursorColor: AppColors.primaryDarken,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Enter your official name",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.greylighten1
                        ),
                        labelText: 'Name',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(
                            0xff858585,
                          ),
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
                      ),
                      validator: (val) => val!.isEmpty
                          ? "You need to enter your name": null,
                      onChanged: (val){
                      },
                    ),
                  ),
                  //email field
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      controller: emailController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      cursorColor: AppColors.primaryDarken,
                      maxLines: null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email address",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.greylighten1
                        ),
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(
                            0xff858585,
                          ),
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
                      ),
                      validator: (val) => val!.isEmpty
                          ? "You need to enter your email":
                      !isValidEmail(val)
                          ? "You need to enter a valid email":null,
                      onChanged: (val){

                      },
                    ),
                  ),
                  //pin field
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      obscureText:  true,
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      controller: pinController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      cursorColor: AppColors.primaryDarken,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6)
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter a pin for your account",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.greylighten1
                        ),
                        labelText: 'Pin',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(
                            0xff858585,
                          ),
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
                      ),
                      validator: (val) => val!.isEmpty
                          ? "You need to enter a pin for your account":
                      val.length<6
                          ? "minimum character length is 6":null,
                      onChanged: (val){

                      },
                    ),
                  ),
                  //postal Address field
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      controller: addressController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      cursorColor: AppColors.primaryDarken,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Enter your postal Address",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.greylighten1
                        ),
                        labelText: 'Address',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(
                            0xff858585,
                          ),
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
                      ),
                      validator: (val) => val!.isEmpty
                          ? "You need to enter your address": null,
                      onChanged: (val){

                      },
                    ),
                  ),
                  //phone field
                  widget.fromOTP == true?const Offstage():
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      controller: phoneController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      cursorColor: AppColors.primaryDarken,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Enter your Phone Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.greylighten1
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
                      ),
                      validator: (val) => val!.isEmpty
                          ? "You need to enter your phone number": null,
                      onChanged: (val){
                      },
                      onSaved: (val){
                        phoneController.text == val;
                      },
                    ),
                  ),

                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      disabled: false,
                      onPressed: (){
                        if(_signUpKey.currentState!.validate()) {
                          _signUpKey.currentState!.save();
                          //generate acct number
                          var accnumber = "";
                          var randomnumber = Random();
                          for (var i = 0; i < 10; i++) {
                            accnumber = accnumber +
                                randomnumber.nextInt(9).toString();
                          }
                          print(accnumber);

                          String userPhone = phoneController.text==
                              null ||
                              phoneController.text== ""? (phone?? ''):
                          "+${selectedCountry
                              .phoneCode}${phoneController.text.trim()}";
                          print("phone number: +${selectedCountry
                              .phoneCode}${phoneController.text.trim()}",);
                          Customer newCustomer = Customer(
                              id: "",
                              name: nameController.text,
                              email: emailController.text,
                              address: addressController.text,
                              phoneNumber: userPhone,
                              pin: pinController.text,
                              createdDate: DateTime.now().toString(),
                              account: accnumber);
                          if (widget.fromOTP == true) {

                            AuthService().storeData(
                                context,
                                newCustomer,
                                (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  const HomePage()
                                  ));
                                }
                            );
                          } else {
                            AuthService().sendPhoneNumber(
                                context,
                                "+${selectedCountry.phoneCode}"
                                "${phoneController.text.trim()}",
                                newCustomer
                            );
                          }
                        }
                        else{
                          showSnackBar(context, "Please Check that all fields "
                              "are filled correctly");
                        }
                      },
                      buttonText: widget.fromOTP== true? "Continue": "Signup",
                    ),
                  ),

                  const SizedBox(height: 20),

                  widget.fromOTP == true?const Offstage():RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? \n",
                          style: TextStyle
                            (fontSize: 14, color: AppColors.textColor),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.of(context).pushReplacement(
                                CupertinoPageRoute(
                                    builder: (context)=> Auth(),
                                ));
                          },
                          text: "Go to Sign In",
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
        ),
      ),
    );
  }
}
