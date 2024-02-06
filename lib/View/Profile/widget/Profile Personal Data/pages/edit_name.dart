import 'package:flutter/material.dart';
import '../../Profile%20Personal%20Data/user/user_data.dart';
import '../../Profile%20Personal%20Data/widgets/appbar_widget.dart';

import 'package:get/get.dart';
import '../../Profile%20Personal%20Data/user/user_data.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  void updateUserValue(String name) {
    user.name = name;
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
                    width: 330,
                    child: Text(
                      "What's Your Name?",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'First Name'),
                              controller: firstNameController,
                            ))),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Last Name'),
                              controller: secondNameController,
                            )))
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ],
            ),
          ),
        ));
  }
}
