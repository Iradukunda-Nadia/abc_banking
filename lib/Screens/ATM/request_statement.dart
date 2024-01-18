import 'package:abc_banking/Models/accountClass.dart';
import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Provider/auth_provider.dart';
import 'package:abc_banking/Screens/ATM/atmHome.dart';
import 'package:abc_banking/Screens/ATM/transaction_page.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/Styling/textStyling.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Statements extends StatefulWidget {
  const Statements({Key? key}) : super(key: key);

  @override
  State<Statements> createState() => _StatementsState();
}

class _StatementsState extends State<Statements> {
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
                        const Text('Somthing went wrong '
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
                    const SizedBox(height: 40),
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
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.date_range)
                              ),
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
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.date_range)
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Text("Search", style: Styling.mediumTextDark,),
                          label: Icon(Icons.fast_forward_outlined, size: 25, color:
                          AppColors.primaryDarken,),
                          onPressed: (){
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

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
                                TransactionPage(transaction: data)));
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
