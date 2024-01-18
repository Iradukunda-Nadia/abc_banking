import 'package:abc_banking/Models/customerClass.dart';
import 'package:abc_banking/Services/customerService.dart';
import 'package:abc_banking/Styling/appColors.dart';
import 'package:abc_banking/WidgetsCustom/custom_button.dart';
import 'package:abc_banking/WidgetsCustom/popup_container.dart';
import 'package:abc_banking/utils/keys.dart';
import 'package:abc_banking/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerDetails extends StatefulWidget {
  final Customer customer;
  const CustomerDetails({Key? key, required this.customer}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  static final _accSettingsKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? pin;
  String? address;

  late Future fetchUser;

  @override
  void initState() {
    fetchUser = CustomerService().fetchCustomer(context, widget.customer.id);
    super.initState();
  }

  Country selectedCountry = Country(
      phoneCode: "44",
      countryCode: "GB",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "United Kingdom",
      example: "United Kingdom",
      displayName: "United Kingdom (GB)",
      displayNameNoCountryCode: "GB",
      e164Key: "");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
            child: FutureBuilder(
                future: fetchUser,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryDarken,
                      ),
                    );
                  }
                  if(snapshot.hasError){
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
                    var data = Customer.fromJson(snapshot.data.data());
                    return Form(
                      key: _accSettingsKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text("You can edit your details below and save to update",
                            textAlign:TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.subTitleColor,
                            ),),
                          const SizedBox(height: 20),
                          //acc no field
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: data.account,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greylighten1,
                              ),
                              cursorColor: AppColors.primaryDarken,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Account number',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(
                                    0xff858585,
                                  ),
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
                            ),
                          ),
                          //name field
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              initialValue: data.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              cursorColor: AppColors.primaryDarken,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Enter your official name",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.greylighten1
                                ),
                                labelText: 'Name',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(
                                    0xff858585,
                                  ),
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
                              validator: (val) => val!.isEmpty
                                  ? "You need to enter your name": null,
                              onChanged: (val){
                                setState(() {
                                  name =val;
                                });
                              },
                            ),
                          ),
                          //email field
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              initialValue: data.email,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              cursorColor: AppColors.primaryDarken,
                              maxLines: null,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Enter your email address",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.greylighten1
                                ),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(
                                    0xff858585,
                                  ),
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
                              validator: (val) => val!.isEmpty
                                  ? "You need to enter your email":
                              !isValidEmail(val)
                                  ? "You need to enter a valid email":null,
                              onChanged: (val){
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                          ),
                          //pin field
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              obscureText:  true,
                              initialValue: data.pin,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              cursorColor: AppColors.primaryDarken,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter a pin for your account",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.greylighten1
                                ),
                                labelText: 'Pin',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(
                                    0xff858585,
                                  ),
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
                              validator: (val) => val!.isEmpty
                                  ? "You need to enter a pin for your account":
                              val.length<6
                                  ? "minimum character length is 6":null,
                              onChanged: (val){
                                setState(() {
                                  pin = val;
                                });
                              },
                            ),
                          ),
                          //postal Address field
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              initialValue: data.address,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              cursorColor: AppColors.primaryDarken,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Enter your postal Address",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.greylighten1
                                ),
                                labelText: 'Address',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(
                                    0xff858585,
                                  ),
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
                              validator: (val) => val!.isEmpty
                                  ? "You need to enter your address": null,
                              onChanged: (val){
                                setState(() {
                                  address = val;
                                });
                              },
                            ),
                          ),
                          //phone field
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: data.phoneNumber,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greylighten1,
                              ),
                              cursorColor: AppColors.primaryDarken,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Enter your Phone Number",
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

                            ),
                          ),

                          const SizedBox(height: 35),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(
                              disabled: name != null && name != data.name ||
                                  email != null && email != data.email ||
                                  address != null && address != data.address ||
                                  pin != null && pin != data.pin? false:true,
                              onPressed: () async {
                                if(_accSettingsKey.currentState!.validate()) {
                                  if(name != null && name != data.name ||
                                      email != null && email != data.email ||
                                      address != null && address != data.address ||
                                      pin != null && pin != data.pin){
                                    var successfulUpdate =
                                    await CustomerService()
                                        .updateCustomer(context,
                                        {"name": name?? data.name,
                                          "email": email?? data.email,
                                          "address": address?? data.address,
                                          "pin": pin?? data.pin,},
                                        widget.customer.id,false);
                                    if(successfulUpdate["status"] == true){
                                      Dialogs.showAlertDialog(
                                          Keys.navigatorKey.currentContext!,
                                          "success",
                                          "account has been updated "
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
                                  else{

                                  }
                                }
                                else{
                                  showSnackBar(context, "Please Check that all fields "
                                      "are filled correctly");
                                }
                              },
                              buttonText: "Update info",
                            ),
                          ),

                          const SizedBox(height: 20),


                        ],
                      ),
                    );
                  }

                }
            ),
          ),
        ),
      ),
    );
  }
}
