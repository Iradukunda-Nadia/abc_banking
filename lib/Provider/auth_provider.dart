import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Screens/AuthScreens/Auth.dart';
import 'package:abc_banking/Screens/AuthScreens/OTP.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtProvider extends ChangeNotifier{
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isOtpLoading = false;
  bool get isOtpLoading => _isOtpLoading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  String? _uid;
  String get uid => _uid!;

  String? _phone;
  String? get phone => _phone;

  Customer? _currCustomer;
  Customer get currCustomer => _currCustomer!;
  
  final FirebaseAuth  _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore  _firebaseFirestore = FirebaseFirestore.instance;


  AtProvider(){
    checkSignIn();
  }

  void checkSignIn() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSignedIn = prefs.getBool("is_signedIn")?? false;
  }

  void phoneSignIn(BuildContext context, String phoneNumber, Customer?
  customerData) async{
    try{
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
          verificationCompleted: ((phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          }), verificationFailed: (error){
          print("Error: ${error.message}");
            throw Exception(error.message);
      },
          codeSent: ((verificationId, forceResendingToken) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>
                    OtpScreen(verificationId: verificationId, customerData:
                    customerData,)));
          }), codeAutoRetrievalTimeout: ((verificationId) {

          }));
    }
    on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String verificationCode,
    required Function onSuccess,
  }) async{
    _isOtpLoading = true;
    notifyListeners();
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: verificationCode);
      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;

      if(user != null){
        _uid = user.uid;
        _phone = user.phoneNumber;
        print("curr user: ${user.uid}");
        _isOtpLoading = false;
        notifyListeners();
        onSuccess();
      } else{
        _isOtpLoading = false;
        notifyListeners();
      }
    } on FirebaseAuthException catch (e){
      showSnackBar(Keys.navigatorKey.currentContext!, e.message.toString());
      _isOtpLoading = false;
      notifyListeners();
    }
  }


  Future<bool> checkExistingUser() async{
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("users").doc(_uid).get();

    if (snapshot.exists){
      print("user already exists");
      _currCustomer = Customer.fromJson(snapshot.data() as Map<String, dynamic>);
      return true;
    }
    else{
      print("user not created yet");
      return false;
    }
  }

  Future<bool> checkExistingAcc(account, pin) async{
    QuerySnapshot snapshot =
    await _firebaseFirestore.collection("users").where("account",
        isEqualTo: account).where("pin", isEqualTo: pin).get();

    if (snapshot.docs.isNotEmpty){
      print("account exists");
      _currCustomer = Customer.fromJson(snapshot.docs.first.data() as Map<String,
          dynamic>);
      return true;
    }
    else{
      print("wrong account details");
      return false;
    }
  }

  Future createNewUser({
  required BuildContext context,
  required Customer newCustomer,
  required Function onSuccess,
}) async{
    _signUpLoading = true;
    notifyListeners();
    newCustomer.id = _uid!;
    await _firebaseFirestore.collection("users").doc(_uid).set(
        newCustomer.toJson()
    ).then((value) async {
      _currCustomer = newCustomer;
      Account newAcc = Account(
          id: _uid!,
        accNumber: newCustomer.account,
        createdDate: newCustomer.createdDate,
         transactions: [],
        total: 0.0,
        savings: 0.0,
        status: "active"
          );
      await _firebaseFirestore.collection("accounts").doc(newCustomer.account).set(
          newAcc.toJson()
      );

      _signUpLoading = false;
      notifyListeners();
      onSuccess();
    }).onError((e, stackTrace) {
      _signUpLoading = false;
      notifyListeners();
      showSnackBar(Keys.navigatorKey.currentContext!, e.toString());
    });
  }

  Future logout() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSignedIn = prefs.getBool("is_signedIn")?? false;

    Navigator.of(Keys.navigatorKey.currentContext!).pushAndRemoveUntil
      (MaterialPageRoute
      (builder:
        (context)=>
        Auth()), (route) => false);
  }

  setCustomer(Customer customer){
    _currCustomer = customer;
    notifyListeners();
  }
}