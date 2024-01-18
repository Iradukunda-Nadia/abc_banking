// to parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  String id;
  String accNumber;
  String? createdDate;
  List<ABCTransaction> transactions;
  double total;
  double savings;
  String status;


  Account({
    required this.id,
    required this.accNumber,
    required this.createdDate,
    required this.transactions,
    required this.total,
    required this.savings,
    required this.status,
  });


  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    accNumber: json["account_number"],
    createdDate: json["created_date"],
    transactions: List<ABCTransaction>.from(json["transactions"].map((x) => x)),
    total: double.parse(json['total'].toString()),
    savings:  json['savings'],
    status: json['status']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_number": accNumber,
    "created_date": createdDate,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    "total": total,
    "savings": savings,
    "status": status,
  };
}

class ABCTransaction {
  String id;
  String transactionType;
  String timestamp;
  double amount;
  String status;
  String? transactionDetails;
  Map? sendTo;
  String description;

  ABCTransaction({
    required this.id,
    required this.transactionType,
    required this.timestamp,
    required this.amount,
    required this.status,
    this.transactionDetails,
    this.sendTo,
    required this.description,
  });


  factory ABCTransaction.fromJson(Map<String, dynamic> json) => ABCTransaction(
    id: json["id"],
    transactionType: json["transactionType"]?? '',
    timestamp: json["timestamp"] ?? '',
    amount: json["amount"],
    status: json["status"],
    transactionDetails: json["transactionDetails"]?? "",
    sendTo: json["sendTo"]?? {},
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transactionType": transactionType,
    "timestamp": timestamp,
    "amount": amount,
    "status": status,
    "transactionDetails": transactionDetails,
    "sendTo": sendTo,
    "description": description
  };
}