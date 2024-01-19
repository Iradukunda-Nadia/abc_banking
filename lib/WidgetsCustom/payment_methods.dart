import 'package:abc_banking/Styling/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethods extends StatefulWidget {
  String? selectedSource;
  ValueChanged<String?>? onChanged;
  PaymentMethods({Key? key, this.onChanged, this.selectedSource}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: SizedBox(
        width: 270,
        child: ListTile(
          title: Text("Bank Transfer"),
          leading: Image.asset('assets/images/bank_transfer_icon.png'),
        ),
      ),value: "Bank Transfer"),
      DropdownMenuItem(child: SizedBox(
        width: 270,
        child: ListTile(
          title: Text("Apple Pay"),
          leading: Image.asset('assets/images/apple_pay_icon.png'),
        ),
      ),value: "Apple Pay"),
      DropdownMenuItem(child: SizedBox(
        width: 270,
        child: ListTile(
          title: Text("Google Pay"),
          leading: Image.asset('assets/images/google_pay_icon.png'),
        ),
      ),value: "Google Pay"),
    ];
    return menuItems;
  }
  String? selectedValue = null;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) => value == null ? "Select a deposit method" : null,
        dropdownColor: Colors.white,
        decoration: InputDecoration(
            hintText: "Select a deposit method",
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
        value: widget.selectedSource,
        onChanged: widget.onChanged,
        items: dropdownItems);
  }
}
