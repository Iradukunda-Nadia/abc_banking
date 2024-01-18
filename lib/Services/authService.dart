
import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../utils/keys.dart';

class AuthService{

  void sendPhoneNumber(context,phoneNumber, Customer? customerData){
    final auth = Provider.of<AtProvider>(context, listen: false);
    auth.phoneSignIn(context, phoneNumber, customerData);

  }

  void verifyOtp(context, otpCode, verificationId, onNewUser, goHome,
      customerData){
    final auth = Provider.of<AtProvider>(context, listen: false);
    auth.verifyOtp(context: context,
        verificationId: verificationId,
        verificationCode: otpCode,
        onSuccess: (){
      print("on Verify Success");
      if(customerData != null){
        AuthService().storeData(
            context,
            customerData,
            goHome
        );
      } else {
            auth.checkExistingUser().then((value) async {
              if (value == true) {
                goHome();
              } else {
                onNewUser();
              }
            });
          }
        });

  }

  void storeData(context, customer, onSuccess){
    final auth = Provider.of<AtProvider>(context, listen: false);
    auth.createNewUser(
        context: context,
        newCustomer: customer,
        onSuccess: onSuccess
    );

  }

}