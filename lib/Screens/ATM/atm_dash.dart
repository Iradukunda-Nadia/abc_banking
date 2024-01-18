import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ATMdash extends StatelessWidget {
  final Widget child;
  const ATMdash({Key? key,
    required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Customer? currentCustomer = Provider.of<AtProvider>(context, listen:
    false).currCustomer;
    return Scaffold(
      backgroundColor: AppColors.primaryDarken,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "${greeting()}, ${currentCustomer.name.toString().split(' ').first}",
          style: Styling.mediumTextLight,
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            child: Text( DateFormat('dd-MMM-yyyy').format(DateTime
                .parse(DateTime.now().toString())),
              style: Styling.largeTextLight,
            ),
          ),
        ],
      ),
      body: child,
    );
  }
}
