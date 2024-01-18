

import 'package:abc_banking/Models/accountClass.dart';

class SampleData{
static List transactions = [
  {
    "id": "1",
    "transactionType": "deposit",
    "timestamp": DateTime.now().toString(),
    "status": "complete",
    "amount": 500.00,
    "description": "School fees"
  },
  {
    "id": "2",
    "transactionType": "withdraw",
    "timestamp": DateTime.now().toString(),
    "status": "complete",
    "amount": 100.00,
    "description": "Rent"
  },
  {
    "id": "3",
    "transactionType": "withdraw",
    "timestamp": DateTime.now().toString(),
    "status": "complete",
    "amount": 100.00,
    "description": "Shopping"
  },
  {
    "id": "4",
    "transactionType": "deposit",
    "timestamp": DateTime.now().toString(),
    "status": "complete",
    "amount": 200.00,
    "description": "Earnings"
  },
  {
    "id": "5",
    "transactionType": "withdraw",
    "timestamp": DateTime.now().toString(),
    "status": "complete",
    "amount": 70.00,
    "description": "Food"
  },
  {
    "id": "6",
    "transactionType": "deposit",
    "timestamp": DateTime.now().toString(),
    "status": "complete",
    "amount": 600.00,
    "description": "Earnings"
  },
];

static final transactionsList = List<ABCTransaction>.from(
    transactions.map((results) => ABCTransaction.fromJson(results)).toList());

static List friends = [
  {
    "id": "1",
    "name": "Olivia Smith",
    "image": "https://www.pexels.com/photo/beautiful-woman-holding-a-flower-7402883/"
  },
  {
    "id": "2",
    "name": "John doe",
    "image": "https://www.pexels.com/photo/man-in-black-jacket-771742/"
  },
  {
    "id": "3",
    "name": "Jane doe",
    "image": "https://www.pexels.com/photo/woman-wearing-black-spaghetti-strap-top-415829/"
  },
  {
    "id": "4",
    "name": "Charles Dickens",
    "image": "https://www.pexels.com/photo/portrait-of-a-man-winking-8159657/"
  },
];

}

