import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String HintText;
  final TextEditingController mycontroller;
  final String LabelText;
  final String validator;

  const CustomTextForm({
    super.key,
    required this.HintText,
    required this.mycontroller,
    required this.LabelText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      textInputAction: TextInputAction.next,
      validator: (val) => val!.isEmpty ? validator : null,
      decoration: InputDecoration(
        hintText: HintText,
        label: Text(LabelText),
        focusedBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(20),
          
        ),
        border: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
     borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
       
      ),
    );
  }
}
