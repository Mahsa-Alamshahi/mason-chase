import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_crud_test/features/add_customer/presentation/bloc/add_customer_bloc.dart';
import 'package:mc_crud_test/features/get_customers/presentation/screens/customers.dart';

import '../../../../config/app_theme.dart';
import '../../../../core/data/data_source/local/customer_entity.dart';
import 'package:intl/intl.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/add_bg.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'First Name',
                    hintText: 'Enter Your First Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Last Name',
                    hintText: 'Enter Your Last Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(child: datePickerWidget()),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    labelText: 'Phone Number',
                    hintText: 'Enter Your Phone Number',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: TextField(
                  controller: bankAccountNumberController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on),
                    labelText: 'Bank Account Number',
                    hintText: 'Enter Your Bank Account Number',
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        BlocProvider.of<AddCustomerBloc>(context)
                            .add(NewCustomerEvent(setCustomerInfo()));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllCustomers()));
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Save"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text("Cancel"),
                        style: ElevatedButton.styleFrom(
                          primary: primaryDarkColor,
                        ),
                      )),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget datePickerWidget() {
    return TextField(
      controller: dateController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.calendar_today), labelText: "Enter Date"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          setState(() {
            dateController.text = formattedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  CustomerEntity setCustomerInfo() {
    return CustomerEntity(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: phoneNumberController.text,
      email: emailController.text,
      dateOfBirth: 555555,
      bankAccountNumber: bankAccountNumberController.text,
    );
  }
}
