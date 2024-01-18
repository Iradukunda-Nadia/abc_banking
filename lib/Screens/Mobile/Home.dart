import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/Mobile/AccountSettings.dart';
import 'package:abc_banking/Screens/Mobile/Action.dart';
import 'package:abc_banking/Screens/Mobile/statements_mobile.dart';
import 'package:abc_banking/Services/accountService.dart';
import 'package:abc_banking/Services/transactionService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/WidgetsCustom/circle_button.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'transactionPage_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _homeScaffoldKey = GlobalKey();
  List actionWidgets = [
    {
      "text": "Deposit",
      "onTap": () {
        Navigator.of(Keys.navigatorKey.currentContext!).push(CupertinoPageRoute(
            builder: (context) => const ActionScreen(
                title: "Deposit",
                description: "Select an amount to deposit into yor account")));
      },
      "icon": Icons.add
    },
    {
      "text": "Withdraw",
      "onTap": () {
        Navigator.of(Keys.navigatorKey.currentContext!).push(CupertinoPageRoute(
            builder: (context) => const ActionScreen(
                title: "Withdraw",
                description: "Select an amount to withdraw")));
      },
      "icon": CupertinoIcons.arrow_down
    },
    {
      "text": "Send",
      "onTap": () {
        Navigator.of(Keys.navigatorKey.currentContext!).push(CupertinoPageRoute(
            builder: (context) => const ActionScreen(
                title: "Send", description: "Select an amount to send")));
      },
      "icon": CupertinoIcons.paperplane
    },
    {"text": "Summary", "onTap": () {
      Navigator.of(Keys.navigatorKey.currentContext!).push(CupertinoPageRoute(
          builder: (context) => const StatementsMobile()));
    }, "icon": CupertinoIcons.ellipsis},
  ];

  @override
  Widget build(BuildContext context) {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good morning';
      }
      if (hour < 17) {
        return 'Good afternoon';
      }
      return 'Good evening';
    }

    Customer currentCustomer =
        Provider.of<AtProvider>(context, listen: false).currCustomer;
    return Scaffold(
      key: _homeScaffoldKey,
      backgroundColor: AppColors.primaryDarken,
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.white.withOpacity(0.0),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8),
          child: Text(
            "${greeting()}, ${currentCustomer.name.toString().split(' ').first}",
            style: Styling.mediumTextLight,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder:
                (context)=> const AccountSettings()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,
                    horizontal: 10),
                child: Icon(
                  Icons.account_circle_sharp,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                AtProvider().logout();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(
                  Icons.logout,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: AccountService().fetchAccount(context),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = Account.fromJson(snapshot.data.data());
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Account Balance",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "£ ${data.total.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: actionWidgets
                              .map<Widget>((data) => CircleButton(
                                    text: data['text'],
                                    buttonIcon: data['icon'],
                                    onTap: data['onTap'],
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: double.infinity, minHeight: 500),
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          elevation: 1,
                          color: AppColors.brightWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Text(
                                  "Recent Transactions",
                                  style: Styling.largeTextDark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70.0),
                                child: Divider(
                                  color: AppColors.primaryDarken,
                                ),
                              ),
                              StreamBuilder(
                                  stream: TransactionService()
                                      .fetchTransactions(context),
                                  builder: (context,
                                      AsyncSnapshot transactionsSnapshot) {
                                    if (transactionsSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryDarken,
                                        ),
                                      );
                                    }
                                    else if (transactionsSnapshot.hasError) {
                                      return Center(
                                          child: Column(
                                        children: [
                                          const Text('Something went wrong '
                                              'while retrieving yor '
                                              'transactions, please check your '
                                              'internet and refresh below'),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {});
                                            },
                                            child: const SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(Icons.refresh),
                                            ),
                                          )
                                        ],
                                      ));
                                    }
                                    else {
                                      return transactionsSnapshot
                                          .data.length<1
                                          ? Column(
                                              children: [
                                                Container(
                                                  width: 250.0,
                                                  height: 250.0,
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(.3),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/emptyTransactions.png',
                                                    width: 120,
                                                    height: 120,
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints(
                                                      maxWidth: 300),
                                                  child: Text(
                                                    "You haven't conducted any transactions yet",
                                                    textAlign: TextAlign.center,
                                                    style: Styling
                                                        .normalTextMessage,
                                                  ),
                                                )
                                              ],
                                            )
                                          : ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: transactionsSnapshot
                                                  .data.length,
                                              itemBuilder: (context, i) {
                                                var data = ABCTransaction.fromJson(
                                                    transactionsSnapshot
                                                        .data[i].data());
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 6),
                                                  child: ListTile(
                                                    onTap: (){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                                          TransactionPageMobile(transaction: data)));
                                                    },
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .top,
                                                    title: Text(
                                                      data.description,
                                                      style: Styling
                                                          .normalTextDark,
                                                    ),
                                                    subtitle: Text(
                                                      DateFormat('(dd-MMM-yyy) '
                                                          'hh:mm')
                                                          .format(DateTime
                                                              .parse(data
                                                                  .timestamp)),
                                                      style: Styling.smallLabel,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8),
                                                    trailing: Text(
                                                      "${data.transactionType == "deposit" ? "" : "-"} £ ${data.amount}",
                                                      style: data.transactionType !=
                                                              "deposit"
                                                          ? Styling
                                                              .largeWarningLabel
                                                          : Styling
                                                              .largeSuccessLabel,
                                                    ),
                                                  ),
                                                );
                                              });
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryDarken,
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Account Balance",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "£ 00.00",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: actionWidgets
                              .map<Widget>((data) => CircleButton(
                                    text: data['text'],
                                    buttonIcon: data['icon'],
                                    onTap: data['onTap'],
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: double.infinity, minHeight: 500),
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          elevation: 1,
                          color: AppColors.brightWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Text(
                                  "Recent Transactions",
                                  style: Styling.largeTextDark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70.0),
                                child: Divider(
                                  color: AppColors.primaryDarken,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 250.0,
                                    height: 250.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/emptyTransactions.png',
                                      width: 120,
                                      height: 120,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 300),
                                    child: Text(
                                      "You haven't conducted any transactions yet",
                                      textAlign: TextAlign.center,
                                      style: Styling.normalTextMessage,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
