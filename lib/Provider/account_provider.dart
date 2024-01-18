
import 'package:abc_banking/Models/accountClass.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier{

  Account? _currAccount;
  Account get currAccount => _currAccount!;

  setAccount(acc){
    _currAccount = acc;
    notifyListeners();
  }

}