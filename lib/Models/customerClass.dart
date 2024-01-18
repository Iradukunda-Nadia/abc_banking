// to parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:abc_banking/Models/accountClass.dart';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  String id;
  String name;
  String email;
  String address;
  String phoneNumber;
  String pin;
  String createdDate;
  String account;


  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.pin,
    required this.createdDate,
    required this.account,
  });


  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    pin: json["pin"],
    createdDate: json["createdDate"],
    account: json["account"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "address": address,
    "phoneNumber": phoneNumber,
    "pin": pin,
    "createdDate": createdDate,
    "account": account,
  };
}

