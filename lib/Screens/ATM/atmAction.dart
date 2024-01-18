import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Screens/ATM/atmHome.dart';
import 'package:abc_banking/Services/accountService.dart';
import 'package:abc_banking/Services/transactionService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/WidgetsCustom/popup_container.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';


class AtmAction extends StatefulWidget {
  final String actionType;
  const AtmAction({Key? key, required this.actionType}) : super(key: key);

  @override
  State<AtmAction> createState() => _AtmActionState();
}

class _AtmActionState extends State<AtmAction> {
  var amountController = MoneyMaskedTextController(leftSymbol: ' £',
      precision: 2,decimalSeparator: '.', thousandSeparator: ',');

  TextEditingController accNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarken,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryDarken,
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context)=> const AtmHome()), (route)
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
      body: StreamBuilder(
          stream: AccountService().fetchAccount(context),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              var data = Account.fromJson(snapshot.data.data());
              return Center(
                child: widget.actionType == "Check Balance"?SizedBox(
                  width: 170,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Available Balance", style: TextStyle(
                          color: AppColors.primaryColor.withOpacity(.6),
                          fontSize: 18
                      ),),
                      Text(data.total.toStringAsFixed(2), style: TextStyle(
                        color: AppColors.brightWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,

                      ),),

                      const SizedBox(height: 20,),

                      Text("Account No:", style: TextStyle(
                          color: AppColors.primaryColor.withOpacity(.6),
                          fontSize: 18
                      ),),
                      Text(data.accNumber, style:
                      TextStyle(
                        color: AppColors.brightWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,

                      ),),
                      const SizedBox(height: 100,),
                      ElevatedButton(
                        child: Text("Go home", style: Styling.mediumTextDark,),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ):
                Column(
                  children: [
                    Text('Please enter an amount or select from the options below',
                      style: TextStyle
                        (fontSize: 35, color: AppColors.primaryColor),),
                    const SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:40,horizontal: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Available Balance", style: TextStyle(
                                    color: AppColors.primaryColor.withOpacity(.6),
                                    fontSize: 18
                                ),),
                                Text(data.total.toStringAsFixed(2), style: TextStyle(
                                  color: AppColors.brightWhite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,

                                ),),

                                const SizedBox(height: 20,),

                                Text("Account No:", style: TextStyle(
                                    color: AppColors.primaryColor.withOpacity(.6),
                                    fontSize: 18
                                ),),
                                Text(data.accNumber, style:
                                TextStyle(
                                  color: AppColors.brightWhite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,

                                ),),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 600,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 500,
                                  color: AppColors.brightWhite,
                                  child: TextFormField(
                                    controller: amountController,
                                    keyboardType:const TextInputType.numberWithOptions(decimal: true),
                                    textAlign: TextAlign.center,
                                    cursorColor: AppColors.primaryDarken,
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter an amount or select from the option below",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          color: AppColors.greylighten1
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(1),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(1),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent
                                          )
                                      ),
                                    ),

                                  ),
                                ),
                                widget.actionType != "Money Transfer"
                                ? const Offstage(): Container(
                                  width: 500,
                                  color: AppColors.brightWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: TextFormField(
                                      scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                      controller: accNoController,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                      cursorColor: AppColors.primaryDarken,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: "Enter account no to "
                                            "transfer to",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppColors.greylighten1
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: AppColors.greylighten1
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: AppColors.greylighten1
                                            )
                                        ),
                                      ),
                                      onChanged: (val){
                                        setState(() {
                                          accNoController.text = val;
                                        });

                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                SizedBox(
                                  width: 500,
                                  height: 200,
                                  child: GridView.count(
                                      crossAxisCount: 2,
                                      childAspectRatio: 200/ 70,
                                      shrinkWrap:  true,
                                      // Generate 100 widgets that display their index in the List.
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            amountController.updateValue(20.0);
                                            setState(() {
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 70,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.primaryColor,
                                                      width: 1),
                                                  color: AppColors.primaryColor.withOpacity(.7)
                                              ),
                                              child: Center(child: Text("£ 20", style: Styling.largeTextDark,)),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            amountController.updateValue(50.0);
                                            setState(() {
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 70,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.primaryColor,
                                                      width: 1),
                                                  color: AppColors.primaryColor.withOpacity(.7)
                                              ),
                                              child: Center(child: Text("£ 50", style: Styling.largeTextDark,)),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            amountController.updateValue(100.0);
                                            setState(() {
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 70,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.primaryColor,
                                                      width: 1),
                                                  color: AppColors.primaryColor.withOpacity(.7)
                                              ),
                                              child: Center(child: Text("£ 100", style: Styling.largeTextDark,)),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            amountController.updateValue(1000.0);
                                            setState(() {
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 70,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.primaryColor,
                                                      width: 1),
                                                  color: AppColors.primaryColor.withOpacity(.7)
                                              ),
                                              child: Center(child: Text("£ 1000", style: Styling.largeTextDark,)),
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: Text("Cancel", style: Styling.mediumTextDark,),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          const SizedBox(width: 20,),
                          ElevatedButton.icon(
                            icon: Text(widget.actionType, style: Styling.mediumTextDark,),
                            label: Icon(Icons.fast_forward_outlined, size: 25, color:
                            AppColors.primaryDarken,),
                            onPressed: (){
                              if(widget.actionType == "Deposit"){
                                deposit(data.total);
                              }
                              if(widget.actionType == "Withdraw"){
                                withdraw(data.total);
                              }
                              if(widget.actionType == "Money Transfer"){
                                send(data.total);
                              }
                              if(widget.actionType == "Cheque Deposit"){
                                chequeDeposit(data.total);
                              }

                            },
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryDarken,
                ),
              );
            }

        }
      ),
    );
  }

  deposit(availableBalance) async {
    ABCTransaction newTransaction = ABCTransaction(
        id: '',
        transactionType: "deposit",
        timestamp: DateTime.now().toString(),
        amount: amountController.numberValue,
        status: "",
        description: "ATM Cash deposit");
    var successfulDeposit = await TransactionService().deposit(
        newTransaction,
        availableBalance,
        context);

    print(successfulDeposit);

    if(successfulDeposit["status"] == true){
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "success",
          "£ ${amountController.numberValue} has been deposited to your account",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
    else{
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "fail",
          "oops Something went wrong, please try again",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
  }
  chequeDeposit(availableBalance) async {
    ABCTransaction newTransaction = ABCTransaction(
        id: '',
        transactionType: "deposit",
        timestamp: DateTime.now().toString(),
        amount: amountController.numberValue,
        status: "",
        description: "ATM Cheque deposit");
    var successfulDeposit = await TransactionService().deposit(
        newTransaction,
        availableBalance,
        context);

    print(successfulDeposit);

    if(successfulDeposit["status"] == true){
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "success",
          "£ ${amountController.numberValue} has been deposited to your account",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
    else{
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "fail",
          "oops Something went wrong, please try again",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
  }
  withdraw(availableBalance) async {
    ABCTransaction newTransaction = ABCTransaction(
        id: '',
        transactionType: "withdraw",
        timestamp: DateTime.now().toString(),
        amount: amountController.numberValue,
        status: "",
        description: "ATM Cash Withdrawal");
    var successfulWithdrawal = await TransactionService().withdraw(
        newTransaction,
        availableBalance,
        context);

    print(successfulWithdrawal);

    if(successfulWithdrawal["status"] == true){
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "success",
          "£ ${amountController.numberValue} has been withdrawn from your "
              "account",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
    else{
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "fail",
          successfulWithdrawal["message"]?? "oops Something went wrong, please "
              "try again",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
  }
  send(availableBalance) async {
    ABCTransaction newTransaction = ABCTransaction(
        id: '',
        transactionType: "send",
        timestamp: DateTime.now().toString(),
        amount: amountController.numberValue,
        status: "",
        transactionDetails: "Transfer to another ABC Banking Group Account",
        sendTo: {"account_number": accNoController.text?? ''},
        description: "ATM money transfer");
    var successfulWithdrawal = await TransactionService().send(
        newTransaction,
        availableBalance,
        context);

    print(successfulWithdrawal);

    if(successfulWithdrawal["status"] == true){
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "success",
          "£ ${amountController.numberValue} has been withdrawn from your "
              "account",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
    else{
      Dialogs.showAlertDialog(
          Keys.navigatorKey.currentContext!,
          "fail",
          successfulWithdrawal["message"]?? "oops Something went wrong, please "
              "try again",
              () {
            Navigator.of(Keys.navigatorKey.currentContext!).pop();
          });
    }
  }
}
