import 'package:flutter/material.dart';
import 'package:trousseau/ui/ServicePage/UserServicesPage.dart';

import '../../../UniversalFunction/UniversalSnackBar.dart';
import '../../../UniversalWidget/mainButtonWidget.dart';
import '../../../UniversalWidget/sign_input_component.dart';
import '../../../UniversalWidget/textFieldTitle.dart';
import '../../../models/userModel.dart';
import '../../../services/DBService.dart';

class SecondStepWidget extends StatefulWidget {
  const SecondStepWidget(
      {Key? key, required this.pageController, required this.myUser})
      : super(key: key);
  final PageController pageController;
  final UserModel myUser;

  @override
  State<SecondStepWidget> createState() => _SecondStepWidgetState();
}

class _SecondStepWidgetState extends State<SecondStepWidget> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _whatsappNumberController =
      TextEditingController();
  bool _isSending = false;

  void _onAddUserTap() async {
    if (_phoneNumberController.text.isEmpty) {
      showUniversalSnackBar(
          context: context,
          message: "Veuillez renseigner votre numéro de téléphone");
      return;
    }

    widget.myUser.phoneNumber = _phoneNumberController.text.replaceAll(" ", "");
    widget.myUser.whatsappNumber =
        _whatsappNumberController.text.replaceAll(" ", "");
    setState(() {
      _isSending = true;
    });
    await
    await DBService().saveUser(widget.myUser).then((result) {
      if (result) {
        showUniversalSnackBar(
            context: context,
            backgroundColor: Colors.green,
            message: "Votre compte a été créé avec succès !");
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserServicesPage(),
            ));
      } else {
        showUniversalSnackBar(
            context: context,
            backgroundColor: Colors.red,
            message:
                "Une erreur s'est produite ! Nous n'avons pas pu creer votre compte");
      }
    });
    setState(() {
      _isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacts",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const MainTextFieldTitleWidget(title: "Numéro de téléphone"),
            PhoneNumberInputComponent(textController: _phoneNumberController),
            const SizedBox(
              height: 20,
            ),
            const MainTextFieldTitleWidget(title: "Numéro Whatsapp"),
            PhoneNumberInputComponent(textController: _whatsappNumberController)
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
              label: "PRÉCÉDENT",
              onPressed: () {
                widget.pageController.jumpToPage(0);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            MainButtonWidget(
              isPrimaryBtn: true,
              label: "SUIVANT",
              onPressed: _onAddUserTap,
              isLoading: _isSending,
            ),
          ],
        ),
      ),
    );
  }
}
