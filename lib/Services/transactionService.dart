import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/account_provider.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/accountClass.dart';

class TransactionService{

  Stream <dynamic> fetchTransactions(context) {
    var acc = Provider.of<AccountProvider>(context, listen: false);
    Customer currentCustomer = Provider.of<AtProvider>(context, listen: false).currCustomer;
    var snapshot = Keys().firebaseFirestore.collection("accounts").doc
      (currentCustomer.account).collection("transactions").orderBy("timestamp",
        descending: true).snapshots().map(
            (querySnap) => querySnap.docs //Mapping Stream of CollectionReference to List<QueryDocumentSnapshot>
        .map((doc) => doc) //Getting each document ID from the data property of
    // QueryDocumentSnapshot
        .toList());
    return snapshot;
  }

  Future <dynamic> deposit(ABCTransaction transaction, total,context) async {
    Customer currentCustomer = Provider.of<AtProvider>(context, listen:
    false).currCustomer;
    var result = {};
    try{
      await Keys().firebaseFirestore.collection("accounts").doc
        (currentCustomer.account).collection("transactions").add(transaction.toJson())
          .then((value) async {
        print("updated transaction");
      });
      await Keys().firebaseFirestore.collection("accounts").doc
        (currentCustomer.account).update({"total":(total+ transaction
          .amount)}).then((value) {
        print("updated account");
      });
      result = {
        "status": true,
        "amount": transaction.amount,
        "message": "success"};
      return result;
    } catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
      result = {"status": false, "amount": transaction.amount,
        "message": "Failed deposit"};
      return result;
    }
  }

  Future <dynamic> withdraw(ABCTransaction transaction, total,context) async {
    Customer currentCustomer = Provider.of<AtProvider>(context, listen:
    false).currCustomer;
    var result = {};
    try{
      if(total< transaction.amount){
        print("You do not have enough funds to complete this transaction");
        result = {
          "status": false,
          "amount": transaction.amount,
          "message": "You do not have enough funds to complete this transaction"
        };
      }
      else {
        await Keys()
            .firebaseFirestore
            .collection("accounts")
            .doc(currentCustomer.account)
            .update({"total": (total - transaction.amount)}).then((value) {
          print("updated account");
        });
        await Keys()
            .firebaseFirestore
            .collection("accounts")
            .doc(currentCustomer.account)
            .collection("transactions")
            .add(transaction.toJson())
            .then((value) async {
          print("updated withdrawal transaction");
        });

        result = {
          "status": true,
          "amount": transaction.amount,
          "message": "success"
        };
      }
      return result;
    } catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
      result = {"status": false, "amount": transaction.amount,
        "message": "success"};
      return result;
    }
  }

  Future <dynamic> send(ABCTransaction transaction, total,context) async {
    Customer currentCustomer = Provider.of<AtProvider>(context, listen:
    false).currCustomer;
    var result = {};
    try{
      if(total< transaction.amount ){
        print("You do not have enough funds to complete this transaction");
        result = {
          "status": false,
          "amount": transaction.amount,
          "message": "You do not have enough funds to complete this transaction"
        };
        return result;
      }
      else if(transaction.amount == 0.0){
        print("You haven't entered any amount");
        result = {
          "status": false,
          "amount": transaction.amount,
          "message": "You do not have enough funds to complete this transaction"
        };
        return result;
      }
      else {
        var snapshot =
        await Keys().firebaseFirestore.collection("accounts")
            .doc(transaction.sendTo!["account_number"]).get();

        if(snapshot.exists) {
          await Keys()
              .firebaseFirestore
              .collection("accounts")
              .doc(transaction.sendTo!["account_number"])
              .update({"total": FieldValue.increment(transaction.amount)})
              .then(
                  (value) {
            print("updated account");
          });
          ABCTransaction sendTo = transaction;
          sendTo.description = "Received from ${currentCustomer.name}";
          await Keys()
              .firebaseFirestore
              .collection("accounts")
              .doc(transaction.sendTo!["account_number"])
              .collection("transactions")
              .add(sendTo.toJson())
              .then((value) async {
            print("updated withdrawal transaction");
          });

          await Keys()
              .firebaseFirestore
              .collection("accounts")
              .doc(currentCustomer.account)
              .update({"total": (total - transaction.amount)}).then((value) {
            print("updated account");
          });
          await Keys()
              .firebaseFirestore
              .collection("accounts")
              .doc(currentCustomer.account)
              .collection("transactions")
              .add(transaction.toJson())
              .then((value) async {
            print("updated withdrawal transaction");
          });

          result = {
            "status": true,
            "amount": transaction.amount,
            "message": "success"
          };
        }
        else{
          result = {
            "status": false,
            "amount": transaction.amount,
            "message": "The account number you entered does not exist in our "
                "system, please check again"
          };
        }
        return result;
      }
    } catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
      result = {"status": false, "amount": transaction.amount,
        "message": "success"};
      return result;
    }
  }

}