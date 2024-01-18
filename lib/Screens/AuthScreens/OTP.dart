import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/AuthScreens/NewUser.dart';
import 'package:abc_banking/Screens/Mobile/Home.dart';
import 'package:abc_banking/Services/authService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/WidgetsCustom/custom_button.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final Customer? customerData;
  const OtpScreen({Key? key,
    required this.verificationId,
    this.customerData
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<AtProvider>(context, listen: true).isOtpLoading;
    return Scaffold(
      backgroundColor: const Color(0xffF2F7EC),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal:30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: ()=> Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
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
                isLoading? Column(
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.primaryDarken,
                    ),
                    const SizedBox(height: 20,),
                    Text("Verifying...", style: TextStyle
                      (fontSize: 16, fontWeight: FontWeight.bold, color:
                    AppColors.primaryDarken),)
                  ],
                ): Form(
                  child: Column(
                    children: [
                      Text('Verification', textAlign:TextAlign.left,
                        style: TextStyle(
                          fontSize:30,
                          color: AppColors.textColor,
                        ),),
                      const SizedBox(height: 10),
                      Text("Enter the OTP code sent to your phone number",
                        textAlign:TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.subTitleColor,
                        ),),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width:60,
                          height:60,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryDarken
                                .withOpacity(0.5)),
                            ),
                        ),
                          onSubmitted:(value){
                            setState(() {
                              otpCode = value;
                            });
                          },
                          onCompleted:(value){
                            setState(() {
                              otpCode = value;
                            });
                          }
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          disabled: false,
                          onPressed: (){
                            if(otpCode != null) {
                              AuthService().verifyOtp(
                                context,
                                otpCode,
                                widget.verificationId,
                                  (){
                                  // register user
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder:
                                            (context)=> const NewUser(
                                              fromOTP: true,
                                            )));

                                  },
                                    (){
                                  // go home
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder:
                                              (context)=> const HomePage()));
                                  },
                                widget.customerData
                              );
                            }
                            else{
                              showSnackBar(context, "Enter 6-Digit code sent "
                                  "to your phone");
                            }
                          },
                          buttonText: 'Verify',
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text("Didn't receive any code?", style: TextStyle
                        (fontSize: 14, color: AppColors.textColor),),
                      Text("Resend New Code?", style: TextStyle
                        (fontSize: 16, fontWeight: FontWeight.bold, color:
                      AppColors.primaryDarken),),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
