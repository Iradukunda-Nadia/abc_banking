import 'package:abc_banking/DATA.dart';
import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Services/customerService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  String? selectedValue;
  ValueChanged<String?>? onChanged;
  Friends({Key? key, this.selectedValue, required this.onChanged}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<DropdownMenuItem<String>>dropdownItems (data){

    var userList = data.docs;
    print("data: $data");

    List<Customer> customers = List<Customer>.from(
        userList.map((result) => Customer.fromJson(result.data() as Map<String,
            dynamic>)).toList
          ());

    List<DropdownMenuItem<String>> menuItems =
    customers.map<DropdownMenuItem<String>>((element) =>
      DropdownMenuItem(value: element.account,
          child: SizedBox(
        width: 270,
        child: ListTile(
          title: Text(element.name),
        ),
      ))
    ).toList();
    return menuItems;
  }
  String? selectedValue = null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: CustomerService().fetchUsers(),
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
          } else{
            return DropdownButtonFormField(
                validator: (value) => value == null ? "Select a friend to send to" : null,
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Select a friend to send to",
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
                value: widget.selectedValue,
                onChanged: widget.onChanged,
                items: dropdownItems(data));
          }

      }
    );
  }
}
