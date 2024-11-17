import 'package:flutter/material.dart';
import 'package:trousseau/UniversalWidget/mainButtonWidget.dart';
import 'package:trousseau/UniversalWidget/main_text_field.dart';
import 'package:trousseau/UniversalWidget/sign_input_component.dart';
import 'package:trousseau/UniversalWidget/textFieldTitle.dart';
import 'package:trousseau/models/userModel.dart';
import 'package:trousseau/ui/UserPages/Widgets/UserAvatarWidget.dart';

class UserProfilPage extends StatefulWidget {
  const UserProfilPage({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  State<UserProfilPage> createState() => _UserProfilPageState();
}

class _UserProfilPageState extends State<UserProfilPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _whatsAppNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstnameController.text = widget.user.firstName ?? "";
    _lastnameController.text = widget.user.lastName ?? "";
    _phoneNumberController.text = widget.user.phoneNumber ?? "";
    _whatsAppNumberController.text = widget.user.whatsappNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        UserAvatarWidget(
                          userProfilImage: widget.user.profilImage,
                        ),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(Icons.edit),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // Divider(),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTextFieldTitleWidget(title: "Votre nom"),
                const SizedBox(
                  height: 5,
                ),
                MainTextFieldWidget(controller: _firstnameController),
                const SizedBox(
                  height: 20,
                ),
                const MainTextFieldTitleWidget(title: "Votre prénom"),
                const SizedBox(
                  height: 5,
                ),
                MainTextFieldWidget(controller: _lastnameController),
                const SizedBox(
                  height: 20,
                ),
                const MainTextFieldTitleWidget(
                    title: "Votre numéro de téléphone"),
                const SizedBox(
                  height: 5,
                ),
                PhoneNumberInputComponent(
                    textController: _phoneNumberController, autofocus: false),
                const MainTextFieldTitleWidget(title: "Votre contact WhatsApp"),
                const SizedBox(
                  height: 5,
                ),
                PhoneNumberInputComponent(
                  textController: _whatsAppNumberController,
                  autofocus: false,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Row(
          children: [
            MainButtonWidget(
                isPrimaryBtn: true, label: "ENREGISTRER LES MODIFICATIONS")
          ],
        ),
      ),
    );
  }
}
