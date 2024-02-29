import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String HintText;
  final TextEditingController? myController;
  final String LabelText;
  final String validator;
  final bool isPassword;
  final TextInputType? keyboardType;

  const CustomTextForm({
    Key? key,
    required this.HintText,
    required this.myController,
    required this.LabelText,
    required this.validator,
    required this.isPassword,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return validator;
        }
        return null;
      },
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        alignLabelWithHint: true,
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
