import 'dart:math';

import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Screens/Admin/CustomerDetails.dart';
import 'package:abc_banking/Services/customerService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/WidgetsCustom/popup_container.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  List<DataRow> _buildList(BuildContext context, data){

    var userList = data.docs;
    print("data: $data");

    List<Customer> customers = List<Customer>.from(
        userList.map((result) => Customer.fromJson(result.data() as Map<String,
            dynamic>)).toList
          ());

    List<DataRow> menuItems =
    customers.map<DataRow>((element) =>
        DataRow(cells: [
          DataCell(Text(element.name)),
          DataCell(Text(element.email)),
          DataCell(Text(element.address)),
          DataCell(Text(element.phoneNumber)),
          DataCell(Text(element.account)),
          DataCell(PopupMenuButton(
            position: PopupMenuPosition.over,
            offset: Offset(20, 30),
            child: Icon(Icons.more_vert),
            onSelected: (String value) async {
              if (value == 'edit'){
                Navigator.of(context).push(CupertinoPageRoute(builder:
                    (context)=> CustomerDetails(customer: element)));
              }
              if (value == 'delete') {
                var successfulUpdate =
                await CustomerService()
                    .deleteCustomerAccount(context,
                    element.id,false);
                if(successfulUpdate["status"] == true){
                  Dialogs.showAlertDialog(
                      Keys.navigatorKey.currentContext!,
                      "success",
                      "Account has been Deleted"
                          "successfully",
                          () {
                        Navigator.of(Keys.navigatorKey.currentContext!).pop();
                      });
                }
                else {
                  Dialogs.showAlertDialog(
                      Keys.navigatorKey.currentContext!,
                      "Fail",
                      "",
                          () {
                        Navigator.of(Keys.navigatorKey.currentContext!).pop();
                      });
                }
              }
              if (value == 'details') {}
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: "edit",
                padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                height: kMinInteractiveDimension ,
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 10,),
                    Text("Edit"),
                  ],
                )
              ),
              const PopupMenuItem<String>(
                  value: "delete",
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                  height: kMinInteractiveDimension ,
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 10,),
                      Text("Delete"),
                    ],
                  )
              ),
              /*
              const PopupMenuItem<String>(
                  value: "details",
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                  height: kMinInteractiveDimension ,
                  child: Row(
                    children: [
                      Icon(Icons.info_rounded),
                      SizedBox(width: 10,),
                      Text("Details"),
                    ],
                  )
              ),*/
            ],
          ))
        ])
    ).toList();
    return menuItems;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: CustomerService().fetchUsersAdmin(),
          builder: (context,
              AsyncSnapshot  snapshot) {
            var data = snapshot.data;
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryDarken,
                ),
              );
            }
            else if(snapshot.hasError){
              print("error: ${snapshot.error}");
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
            else{
              return SingleChildScrollView(
                child: Center(
                  child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('EMAIL')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Phone')),
                        DataColumn(label: Text('Account No')),
                        DataColumn(label: Text('MANAGE')),
                      ],
                      rows: _buildList(context, data)
                  ),
                ),
              );}
        }
      ),
    );
  }
}
