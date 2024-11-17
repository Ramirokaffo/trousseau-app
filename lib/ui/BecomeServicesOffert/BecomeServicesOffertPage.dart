import 'package:flutter/material.dart';
import 'package:trousseau/ui/BecomeServicesOffert/Widgets/FirstStepWidget.dart';
import 'package:trousseau/ui/BecomeServicesOffert/Widgets/SecondStepWidget.dart';

import '../../models/userModel.dart';
import '../../services/authService.dart';

class BecomeServicesOfferPage extends StatefulWidget {
  const BecomeServicesOfferPage({Key? key}) : super(key: key);

  @override
  State<BecomeServicesOfferPage> createState() =>
      _BecomeServicesOfferPageState();
}

class _BecomeServicesOfferPageState extends State<BecomeServicesOfferPage> {
  final PageController _pageController = PageController();
  final UserModel _myUser = UserModel(id: AuthService.user!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: _pageController,
          children: [
            FirstStepWidget(
              pageController: _pageController,
              myUser: _myUser,
            ),
            SecondStepWidget(
              pageController: _pageController,
              myUser: _myUser,
            )
          ],
        ),
      ),
    );
  }
}
