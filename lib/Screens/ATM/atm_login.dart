import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/ATM/atmHome.dart';
import 'package:abc_banking/Screens/ATM/atm_dash.dart';
import 'package:abc_banking/Screens/Admin/admin_dashboard.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AtmLogin extends StatefulWidget {
  const AtmLogin({Key? key}) : super(key: key);

  @override
  State<AtmLogin> createState() => _AtmLoginState();
}

class _AtmLoginState extends State<AtmLogin> {

  final accController = TextEditingController();
  final pinController = TextEditingController();
  final _atmLogInKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryDarken,
      appBar: AppBar(
        title: Text(
          greeting(),
          style: Styling.mediumTextLight,
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            child: Text( DateFormat('dd-MMM-yyyy').format(DateTime
                .parse(DateTime.now().toString())),
              style: Styling.largeTextLight,
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 750,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Please enter your account number and pin-number',
                    textAlign: TextAlign.center,
                    style: TextStyle
                      (fontSize: 35, color: AppColors.primaryColor),),
                  const SizedBox(height: 80,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0),
                    child: Form(
                        key: _atmLogInKey,
                        child: Column(
                          children: [
                            //acc field
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: AppColors.brightWhite,
                                    border: Border.all(color: AppColors.primaryDarken,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: TextFormField(
                                  scrollPadding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom),
                                  controller: accController,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                  cursorColor: AppColors.primaryDarken,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Enter your account number",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.greylighten1
                                    ),
                                    labelText: 'Account number',
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
                                      ? "You need to enter your account number": null,
                                  onChanged: (val){

                                  },
                                ),
                              ),
                            ),
                            //pin field
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: AppColors.brightWhite,
                                    border: Border.all(color: AppColors.primaryDarken,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(10)
                                ),
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
                                    hintText: "Enter the pin for your account",
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
                                      ? "You need to enter the pin for your account":
                                  val.length<6
                                      ? "minimum character length is 6":null,
                                  onChanged: (val){

                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
              Positioned(
                right: 140,
                bottom: 120,
                child: ElevatedButton.icon(
                  icon: Text('Next', style: Styling.mediumTextDark,),
                  label: Icon(Icons.fast_forward_outlined, size: 25, color:
                  AppColors.primaryDarken,),
                  onPressed: (){
                    if(accController.text == "ABC-BANK-ADMIN" &&
                        pinController.text == "123456"){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder:
                              (context)=> const AdminDashboard()));
                    }
                    else if(_atmLogInKey.currentState!.validate()) {
                      Provider.of<AtProvider>(context, listen: false)
                          .checkExistingAcc(accController.text,
                          pinController.text).then((value) async {
                        if (value == true) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder:
                                  (context)=> const AtmHome()));
                        } else {
                          showSnackBar(context, "Please Check that "
                              "you entered the correct details");
                        }
                      });
                    }
                    else{
                      showSnackBar(context, "Please Check that all fields "
                          "are filled correctly");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
