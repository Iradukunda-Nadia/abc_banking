import 'dart:async';
import 'dart:convert';

import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/account_provider.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/ATM/atm_login.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';


const storage = FlutterSecureStorage();

class CustomerService{

  Future <QuerySnapshot> fetchUsers() async {
    Customer currentCustomer = Provider.of<AtProvider>(Keys.navigatorKey
        .currentContext!,
        listen: false)
        .currCustomer;
    var snapshot = Keys().firebaseFirestore.collection("users").where("id",
        isNotEqualTo: currentCustomer.id).get();
    return snapshot;
  }

  Stream <QuerySnapshot> fetchUsersAdmin() {

    var snapshot = Keys().firebaseFirestore.collection("users").snapshots();
    return snapshot;
  }

  Future <dynamic> atmLogin() async {
    var snapshot = Keys().firebaseFirestore.collection("users").snapshots().map(
            (querySnap) => querySnap.docs
            .map((doc) => doc)
            .toList());
    return snapshot;
  }

  Future <dynamic> fetchCustomer(context, id) {

    var snapshot = Keys().firebaseFirestore.collection("users").doc
      (id).get();

    return snapshot;
  }

  Future <dynamic> updateCustomer(context, account, id, fromSettings) async {
    var result = {};
    try{
      await Keys().firebaseFirestore.collection("users").doc
        (id).update(account)
          .then((value) async {
        DocumentSnapshot snapshot = await Keys().firebaseFirestore.collection
          ("users").doc(id).get();
        if(fromSettings == true){
          var auth = Provider.of<AtProvider>(context, listen:
          false);
          auth.setCustomer (Customer.fromJson(snapshot.data() as Map<String,
        dynamic>));
        }

        result = {
          "status": true,
          "message": "success"};
      });
      return result;
    } catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
      result = {"status": false, "message": "failed"};
      return result;
    }
  }

  Future <dynamic> deleteCustomerAccount(context, id, fromSettings) async {
    var result = {};
    try{
      await Keys().firebaseFirestore.collection("users").doc
        (id).delete()
          .then((value) async {
        result = {
          "status": true,
          "message": "success"};
      });
      return result;
    } catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
      result = {"status": false, "message": "failed"};
      return result;
    }
  }

  Future <dynamic> statement(period, accNo) async {
    return accNo;
  }

  Future <dynamic> checkBalance(accNo) async {
    double balance = 0.0;
    return balance;
  }

}