import 'package:flutter/material.dart';
import 'package:trousseau/ui/ServicePage/UserServicesPage.dart';

import '../BecomeServicesOffert/BecomeServicesOffertPage.dart';

List<Map<String, dynamic>> drawerData(BuildContext context) {
  return [
    {
      "title": "Mes services",
      "icon": Icons.list,
      "onTap": () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const UserServicesPage(),
          ))
    },
    {
      "title": "Proposer mes services",
      "icon": Icons.list,
      "onTap": () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const BecomeServicesOfferPage(),
          ))
    },
    {"title": "Déconnexion", "icon": Icons.logout, "onTap": () {}},
  ];
}
