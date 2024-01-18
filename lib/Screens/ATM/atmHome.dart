import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/ATM/atmAction.dart';
import 'package:abc_banking/Screens/ATM/atm_dash.dart';
import 'package:abc_banking/Screens/ATM/request_statement.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/WidgetsCustom/atm_option.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AtmHome extends StatefulWidget {
  const AtmHome({Key? key}) : super(key: key);

  @override
  State<AtmHome> createState() => _AtmHomeState();
}

class _AtmHomeState extends State<AtmHome> {

  @override
  Widget build(BuildContext context) {

    return ATMdash(child: Center(
      child: Container(
        width: 750,
        decoration: BoxDecoration(
            border: Border.symmetric(vertical:BorderSide(
                color: AppColors.grey1,
                width: 2
            ))
        ),
        child: Column(
          children: [
            Text('Please Select a service', style: TextStyle
              (fontSize: 35, color: AppColors.primaryColor),),
            const SizedBox(height: 80,),

            Padding(
              padding: EdgeInsets.symmetric(vertical:
              30),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AtmOption(
                    isRight: false,
                    title: "Cash Deposit",
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>
                              const AtmAction(actionType: "Deposit")));
                    },
                  ),
                  AtmOption(
                    isRight: true,
                    title: "Withdraw",
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>
                          const AtmAction(actionType: "Withdraw")));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:
              20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AtmOption(
                    isRight: false,
                    title: "Transfer Funds",
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>
                          const AtmAction(actionType: "Money Transfer")));
                    },
                  ),
                  AtmOption(
                    isRight: true,
                    title: "Cheque deposit",
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>
                          const AtmAction(actionType: "Cheque Deposit")));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:
              20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AtmOption(
                    isRight: false,
                    title: "Request Statement",
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>
                          const Statements()));
                    },
                  ),
                  AtmOption(
                    isRight: true,
                    title: "Check Balance",
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>
                          const AtmAction(actionType: "Check Balance")));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
