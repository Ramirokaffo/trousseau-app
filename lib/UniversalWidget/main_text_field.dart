import 'package:flutter/material.dart';

class MainTextFieldWidget extends StatelessWidget {
  const MainTextFieldWidget(
      {Key? key,
      required this.controller,
      this.keyboardType,
      this.hintText,
      this.autofocus,
      this.maxLines})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool? autofocus;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50.0,
      child: TextFormField(
        autofocus: autofocus ?? false,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        controller: controller,
        // maxLength: 500,
        maxLines: maxLines,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.zero),
            hintText: hintText),
      ),
    );
  }
}
