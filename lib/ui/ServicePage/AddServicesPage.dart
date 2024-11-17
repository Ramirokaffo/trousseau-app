import 'package:flutter/material.dart';
import 'package:trousseau/UniversalWidget/mainButtonWidget.dart';
import 'package:trousseau/models/ServicesModel.dart';

import '../../UniversalFunction/UniversalSnackBar.dart';
import '../../UniversalWidget/main_text_field.dart';
import '../../UniversalWidget/textFieldTitle.dart';
import '../../services/authService.dart';

class AddServicesPage extends StatefulWidget {
  const AddServicesPage({Key? key}) : super(key: key);

  @override
  State<AddServicesPage> createState() => _AddServicesPageState();
}

class _AddServicesPageState extends State<AddServicesPage> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceDescriptionController =
      TextEditingController();
  bool _isSaving = false;

  void _onSaveTap() async {
    if (_serviceNameController.text.isEmpty) {
      showUniversalSnackBar(
          context: context, message: "Veuillez renseigner le nom du service");
      return;
    }
    ServicesModel myService = ServicesModel(
        title: _serviceNameController.text,
        description: _serviceDescriptionController.text);
    setState(() {
      _isSaving = true;
    });
    await myService.save().then((value) {
      if (value) {
        showUniversalSnackBar(
            backgroundColor: Colors.green,
            context: context,
            message: "Votre service a été ajouté avec succès");
        Navigator.of(context).pop(true);
      } else {
        showUniversalSnackBar(
            backgroundColor: Colors.red,
            context: context,
            message:
                "Nous n'avons pas pu ajouter votre service, veuilez reéssayer !");
      }
    });
    setState(() {
      _isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(AuthService.user!.uid);
    // print(AuthService.user!);
    // print(AuthService.user!.phoneNumber);
    // Navigator.of(context).push(route);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un service"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              const MainTextFieldTitleWidget(title: "Nom du service"),
              const SizedBox(
                height: 5,
              ),
              MainTextFieldWidget(
                controller: _serviceNameController,
                hintText: "Entrez le nom du service ici",
              ),
              const SizedBox(
                height: 30,
              ),
              const MainTextFieldTitleWidget(title: "Description du service"),
              const SizedBox(
                height: 5,
              ),
              MainTextFieldWidget(
                controller: _serviceDescriptionController,
                hintText: "Entrez la description du service ici",
                maxLines: 6,
              ),
            ],
          )),
      bottomSheet: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MainButtonWidget(
              isPrimaryBtn: true,
              label: "ENREGISTRER",
              onPressed: _onSaveTap,
              isLoading: _isSaving,
            ),
          ],
        ),
      ),
    );
  }
}
