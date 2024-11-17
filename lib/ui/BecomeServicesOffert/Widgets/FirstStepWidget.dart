import 'package:flutter/material.dart';
import 'package:trousseau/UniversalFunction/UniversalSnackBar.dart';
import 'package:trousseau/UniversalWidget/mainButtonWidget.dart';
import 'package:trousseau/UniversalWidget/main_text_field.dart';
import 'package:trousseau/UniversalWidget/textFieldTitle.dart';

import '../../../models/userModel.dart';

class FirstStepWidget extends StatefulWidget {
  const FirstStepWidget(
      {Key? key, required this.pageController, required this.myUser})
      : super(key: key);
  final PageController pageController;
  final UserModel myUser;
  @override
  State<FirstStepWidget> createState() => _FirstStepWidgetState();
}

class _FirstStepWidgetState extends State<FirstStepWidget> {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _onNextTap() {
    if (_firstNameController.text.isEmpty) {
      showUniversalSnackBar(
          context: context, message: "Veuillez renseigner votre nom");
      return;
    } else if (_emailController.text.isEmpty) {
      showUniversalSnackBar(
          context: context, message: "Veuillez renseigner votre adresse mail");
      return;
    }
    widget.myUser.firstName = _firstNameController.text;
    widget.myUser.lastName = _lastNameController.text;
    widget.myUser.email = _emailController.text;
    widget.pageController.jumpToPage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Infos personnelles",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const MainTextFieldTitleWidget(title: "Nom"),
            const SizedBox(
              height: 5,
            ),
            MainTextFieldWidget(
              controller: _firstNameController,
              hintText: "Entrez votre nom ici",
            ),
            const SizedBox(
              height: 20,
            ),
            const MainTextFieldTitleWidget(title: "Prénom"),
            const SizedBox(
              height: 5,
            ),
            MainTextFieldWidget(
              controller: _lastNameController,
              hintText: "Entrez votre prénom ici",
            ),
            const SizedBox(
              height: 20,
            ),
            const MainTextFieldTitleWidget(title: "Adresse mail"),
            const SizedBox(
              height: 5,
            ),
            MainTextFieldWidget(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Entrer votre adresse mail",
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            MainButtonWidget(
              isPrimaryBtn: false,
              label: "QUITTER",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            MainButtonWidget(
              isPrimaryBtn: true,
              label: "SUIVANT",
              onPressed: _onNextTap,
            ),
          ],
        ),
      ),
    );
  }
}
