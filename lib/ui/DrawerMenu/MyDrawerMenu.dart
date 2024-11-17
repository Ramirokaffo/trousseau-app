import 'package:flutter/material.dart';
import 'package:trousseau/models/userModel.dart';
import 'package:trousseau/ui/UserPages/UserProfilPage.dart';
import 'package:trousseau/ui/UserPages/Widgets/UserAvatarWidget.dart';

import 'Data.dart';

class MyDrawerMenu extends StatelessWidget {
  const MyDrawerMenu({Key? key, this.user}) : super(key: key);
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.white
        // ),
        child: ListView(
          children: [
            // UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.red
            //   ),
            //     accountName: Text("Le nom du user"),
            //     accountEmail: Text("L'email")),
            DrawerHeader(
                child: Column(
              children: [
                // IconButton(
                //   onPressed: () {}, icon: const Icon(Icons.person),
                //   // color: Colors.black,
                //   style: ButtonStyle(
                //       backgroundColor: MaterialStatePropertyAll(
                //           Colors.black.withOpacity(0.2))),
                //   iconSize: 50,
                // ),
                InkWell(
                  onTap: () {
                    if (user != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserProfilPage(user: user!),
                      ));
                    }
                  },
                  child: UserAvatarWidget(
                    userProfilImage: (user != null) ? user!.profilImage : null,
                  ),
                ),
                // if
                (user != null)
                    ? Text("${user!.lastName} ${user!.firstName}")
                    : const SizedBox(),
              ],
            )),
            ...drawerData(context).map((element) => ListTile(
                  title: Text(element["title"]),
                  leading: Icon(element["icon"]),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: element["onTap"],
                )),
          ],
        ),
      ),
    );
  }
}
