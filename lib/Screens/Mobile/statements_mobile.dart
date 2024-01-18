import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/Mobile/Home.dart';
import 'package:abc_banking/Screens/Mobile/transactionPage_mobile.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StatementsMobile extends StatefulWidget {
  const StatementsMobile({Key? key}) : super(key: key);

  @override
  State<StatementsMobile> createState() => _StatementsMobileState();
}

class _StatementsMobileState extends State<StatementsMobile> {
  DateTime? _selectedStartDate = DateTime(2024, 1);
  TextEditingController _date1Controller = TextEditingController();

  DateTime? _selectedEndDate = DateTime.now();
  TextEditingController _date2Controller = TextEditingController();

  _selectDate1(context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate?? DateTime.now(),
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2025, 12),
    );

    if (newSelectedDate != null) {
      _selectedStartDate = newSelectedDate;
      _date1Controller
        ..text = DateFormat.yMMMd().format(_selectedStartDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _date1Controller.text.length,
            affinity: TextAffinity.upstream));
    }
    setState(() {

    });
  }

  _selectDate2(context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate?? DateTime.now(),
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2025, 12),
    );

    if (newSelectedDate != null) {
      _selectedEndDate = newSelectedDate;
      _date2Controller
        ..text = DateFormat.yMMMd().format(_selectedEndDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _date2Controller.text.length,
            affinity: TextAffinity.upstream));
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Customer currentCustomer = Provider.of<AtProvider>(context, listen: false).currCustomer;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Transactions", style:Styling.mediumTextLight,),
        backgroundColor: AppColors.primaryDarken,
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context)=> const HomePage()), (route)
              => false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:
              8),
              child: Icon(Icons.logout, size: 20, color: AppColors
                  .primaryColor,),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Keys().firebaseFirestore.collection("accounts").doc
              (currentCustomer.account).collection("transactions")
                .where("timestamp", isGreaterThanOrEqualTo: _selectedStartDate.toString())
                .where("timestamp", isLessThanOrEqualTo:  _selectedEndDate.toString
              ()).orderBy
              ("timestamp",
                descending: true).snapshots().map(
                    (querySnap) => querySnap.docs //Mapping Stream of CollectionReference to List<QueryDocumentSnapshot>
                    .map((doc) => doc)
                    .toList()),
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
                            'transactions, please chech your '
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
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: const Text("Start Date"),
                            title: TextFormField(
                              autofocus: false,
                              readOnly: true,
                              onTap: (){_selectDate1(context);},
                              controller: _date1Controller,

                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: const Text("End Date"),
                            title: TextFormField(
                              autofocus: false,
                              readOnly: true,
                              onTap: (){_selectDate2(context);},
                              controller: _date2Controller,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    transactionsSnapshot
                        .data.length<1
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          constraints: BoxConstraints(
                              maxWidth: 300),
                          child: Text(
                            "There are no transactions for the selected dates",
                            textAlign: TextAlign.center,
                            style: Styling
                                .normalTextMessage,
                          ),
                        )
                      ],
                    )
                        :ListView.builder(
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
                        })
                  ],
                );
              }

            }
        ),
      ),

    );
  }

}
