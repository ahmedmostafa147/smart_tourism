import 'package:smart_tourism/view/Profile/user/user_data.dart';
import 'package:smart_tourism/view/Profile/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void updateUserValue(String phone) {
    String formattedPhoneNumber =
        "(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6, phone.length)}";
    user.phone = formattedPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: 320,
                      child: Text(
                        "What's Your Phone Number?",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                          height: 100,
                          width: 320,
                          child: TextFormField(
                            // Handles Form Validation

                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Your Phone Number',
                            ),
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 320,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Update',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          )))
                ]),
          ),
        ));
  }
}
