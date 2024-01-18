import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Screens/Mobile/Home.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionPageMobile extends StatefulWidget {
  final ABCTransaction transaction;
  const TransactionPageMobile({Key? key, required this.transaction}) : super
      (key: key);

  @override
  State<TransactionPageMobile> createState() => _TransactionPageMobileState();
}

class _TransactionPageMobileState extends State<TransactionPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarken,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primaryDarken,
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context)=> const HomePage()), (route)
              => false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical:
              12),
              child: Icon(Icons.logout, size: 40, color: AppColors.primaryColor,),
            ),
          )
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Container(
                width: 700,
                decoration: BoxDecoration(
                    color: AppColors.brightWhite,
                    border: Border(
                      left: BorderSide(
                          color: AppColors.brightWhite,
                          width: 3
                      ),
                      right: BorderSide(
                          color: AppColors.brightWhite,
                          width: 3
                      ),
                    )
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Transaction Details', style: TextStyle
                        (fontSize: 35, color: AppColors.textColor),),
                      const SizedBox(height: 80,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Transaction Type", style: Styling
                                .normalTextDark,),
                            Text(widget.transaction.transactionType, style: Styling
                                .normalTextDark,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Amount", style: Styling.normalTextDark,),
                            Text(widget.transaction.amount.toStringAsFixed(2), style: Styling
                                .normalTextDark,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date", style: Styling.normalTextDark,),
                            Text(
                              DateFormat('(dd-MMM-yyy) '
                                  'hh:mm')
                                  .format(DateTime
                                  .parse(widget.transaction.timestamp)), style:
                            Styling
                                .normalTextDark,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description", style: Styling.normalTextDark,),
                            Text(widget.transaction.description, style:
                            Styling
                                .normalTextDark,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Transaction Details", style: Styling
                                .normalTextDark,
                            ),
                            Expanded(
                              child: Text(widget.transaction.transactionDetails??'', style:
                              Styling
                                  .normalTextDark,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}
