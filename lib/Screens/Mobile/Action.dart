import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Provider/account_provider.dart';
import 'package:abc_banking/Services/accountService.dart';
import 'package:abc_banking/Services/transactionService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/WidgetsCustom/custom_button.dart';
import 'package:abc_banking/WidgetsCustom/friends_list.dart';
import 'package:abc_banking/WidgetsCustom/payment_methods.dart';
import 'package:abc_banking/WidgetsCustom/popup_container.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

class ActionScreen extends StatefulWidget {
  final String title;
  final String description;

  const ActionScreen({Key? key,
  required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  var amountController = MoneyMaskedTextController(leftSymbol: ' £',
      precision: 2,decimalSeparator: '.', thousandSeparator: ',');
  TextEditingController payRefController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var acc = Provider.of<AccountProvider>(Keys.navigatorKey.currentContext!,
      listen: false)
      .currAccount;

  String? selectedFriend;
  String? selectedSource;

  @override
  Widget build(BuildContext context) {
    payRefController.selection =TextSelection.fromPosition(TextPosition
      (offset: payRefController.text.length));

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: (){Navigator.of(context).pop();},
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(CupertinoIcons.back, color: AppColors.greyDarken8,),
            )),
        title: Text(widget.title, style: Styling.appbarTitle,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(widget.description, style: Styling.normalTextDark,),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListTile(

                leading: GestureDetector(
                  onTap: (){
                    if(amountController.numberValue> 0.00) {
                        double newVal = (amountController.numberValue - 1.00);
                        amountController.updateValue(newVal);
                        setState(() {
                        });
                      }
                    },
                  child: Icon(
                    Icons.remove_rounded,
                    color: AppColors.primaryDarken,
                    weight: 900,
                    size: 25,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: (){
                    double newVal = (amountController.numberValue +1.00);
                    amountController.updateValue(newVal);
                    setState(() {});

                  },
                  child: Icon(
                    Icons.add_rounded,
                    color: AppColors.primaryDarken,
                    weight: 900,
                    size: 25,
                  ),
                ),
                title: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
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
                              hintText: "00.00",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: AppColors.greylighten1
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent
                                  )
                              ),
                          ),
                          onChanged: (val){
                            setState(() {});
                          },

                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),


            widget.title == "Deposit"?
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text ("Payment source", style: Styling
                        .normalTextDark,),
                      const SizedBox(height: 10,),
                      PaymentMethods(
                        selectedSource: selectedSource,
                        onChanged: (String? newValue) {
                          setState(() {
                            print(newValue);
                            selectedSource = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ): const Offstage(),

            widget.title == "Send"?
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text ("Select a friend to send to", style: Styling
                      .normalTextDark,),
                  const SizedBox(height: 10,),
                  Friends(
                    key: const ValueKey('friends'),
                    selectedValue: selectedFriend,
                    onChanged: (String? newValue) {
                      setState(() {
                        print(newValue);
                        selectedFriend = newValue!;
                      });
                    },
                  )
                ],
              ),
            ): const Offstage(),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: payRefController,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
                cursorColor: AppColors.primaryDarken,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Enter a payment Reference",
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
                    payRefController.text = val;
                  });

                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  key: UniqueKey(),
                  disabled: amountController.numberValue <= 0.00?true:false,
                  onPressed: () async {
                    if(widget.title == "Deposit"){deposit();}
                    if(widget.title == "Withdraw"){withdraw();}
                    if(widget.title == "Save"){}
                    if(widget.title == "Send"){send();}
                  },
                  buttonText: 'Continue',
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  deposit() async {
    ABCTransaction newTransaction = ABCTransaction(
        id: '',
        transactionType: "deposit",
        timestamp: DateTime.now().toString(),
        amount: amountController.numberValue,
        status: "",
        transactionDetails: selectedSource != null?"deposit made from "
            "$selectedSource":"",
        description: payRefController.text?? "deposit");
    var successfulDeposit = await TransactionService().deposit(
        newTransaction,
        acc.total,
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
  withdraw() async {
    ABCTransaction newTransaction = ABCTransaction(
        id: '',
        transactionType: "withdraw",
        timestamp: DateTime.now().toString(),
        amount: amountController.numberValue,
        status: "",
        description: payRefController.text?? "withdrawal");
    var successfulWithdrawal = await TransactionService().withdraw(
        newTransaction,
        acc.total,
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
  send() async {
    ABCTransaction newTransaction = ABCTransaction(
        id: '',
        transactionType: "send",
        timestamp: DateTime.now().toString(),
        amount: amountController.numberValue,
        status: "",
        transactionDetails: "Send To another customer on ABC BANKING "
            "- Account number: $selectedFriend",
        sendTo: {"account_number": selectedFriend?? ''},
        description: payRefController.text?? "SENT");
    var successfulWithdrawal = await TransactionService().withdraw(
        newTransaction,
        acc.total,
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
