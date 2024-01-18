import 'dart:async';
import 'dart:convert';

import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/account_provider.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';


const storage = FlutterSecureStorage();

class AccountService{

  Stream <dynamic> fetchAccount(context) {
    var acc = Provider.of<AccountProvider>(context, listen: false);
    Customer currentCustomer = Provider.of<AtProvider>(context, listen: false).currCustomer;
    var snapshot = Keys().firebaseFirestore.collection("accounts").doc
      (currentCustomer.account).snapshots();
    snapshot.forEach((element) {
      acc.setAccount(Account.fromJson(element.data() as Map<String, dynamic>));
    });

    return snapshot;
  }

  Future <dynamic> statement(period, accNo) async {
    return accNo;
  }

  Future <dynamic> checkBalance(accNo) async {
    return accNo;
  }

}