import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutocompleteField extends StatelessWidget {
  final String label;
  final List<String> options;
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onSelected;
  final RxBool isValidSelection;

  const AutocompleteField({
    required this.label,
    required this.options,
    required this.controller,
    required this.hintText,
    required this.isValidSelection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return options;
            }
            return options.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            controller.text = selection;
            if (onSelected != null) {
              onSelected!(selection);
            }
            isValidSelection.value =
                true; // Update the RxBool when an option is selected
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            fieldFocusNode.addListener(() {
              if (fieldFocusNode.hasFocus &&
                  fieldTextEditingController.text.isEmpty) {
                fieldTextEditingController.text = " ";
                Future.delayed(Duration.zero, () {
                  fieldTextEditingController.clear();
                });
              }
            });
            controller.value = fieldTextEditingController.value;
            return Obx(() => TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: InputDecoration(
                    hintText: hintText,
                    labelText: label,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: isValidSelection.value
                        ? null
                        : 'Invalid selection', // Display error if not a valid selection
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter $label';
                    }
                    return null;
                  },
                ));
          },
        ),
      ],
    );
  }
}
