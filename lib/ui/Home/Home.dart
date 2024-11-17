import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trousseau/services/DBService.dart';
import 'package:trousseau/ui/Home/ServiceUsersPage.dart';

import '../../models/ServicesModel.dart';
import '../../models/userModel.dart';
import '../../services/authService.dart';
import '../DrawerMenu/MyDrawerMenu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ServicesModel> _listServices = [];

  AuthService authService = AuthService();
  bool _isLoading = true;
  UserModel? localUser;

  void _getUserServices() async {
    await ServicesModel.getServices().then((List<ServicesModel> userServices) {
      _listServices.addAll(userServices);
    });
    setState(() {
      _isLoading = false;
    });
  }

  void _getLocalUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DBService.getLocalUser().then((UserModel? user) async {
        localUser = user;
        // _fetchStatus = FetchStatus.success;
        setState(() {});
      });
    } else {
      authService.signInAnonymous();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserServices();
    _getLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    // DBService().saveUser(UserModel(id: "toto", email: "ramiro@gmail.com", login: "Son login"));
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Trousseau"),
        elevation: 5,
      ),
      drawer: MyDrawerMenu(
        user: localUser,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceUsersPage(
                                  service: _listServices[index]),
                            ));
                      },
                      child: ListTile(
                        title: Text(_listServices[index].title!),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: _listServices.length),
            ),
    );
  }
}
