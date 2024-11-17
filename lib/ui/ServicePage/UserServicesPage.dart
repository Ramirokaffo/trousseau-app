import 'package:flutter/material.dart';
import 'package:trousseau/ui/ServicePage/AddServicesPage.dart';

import '../../models/ServicesModel.dart';
import '../../models/userModel.dart';
import '../../services/DBService.dart';

class UserServicesPage extends StatefulWidget {
  const UserServicesPage({Key? key}) : super(key: key);

  @override
  State<UserServicesPage> createState() => _UserServicesPageState();
}

class _UserServicesPageState extends State<UserServicesPage> {
  bool _isLoading = true;
  final List<ServicesModel> _listServices = [];
  late UserModel localUser;

  void _getUserServices() async {
    await ServicesModel.getUserServices()
        .then((List<ServicesModel> userServices) {
      _listServices.addAll(userServices);
    });
    localUser = (await DBService.getLocalUser())!;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes services"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    // print(localUser.principalServiceId);
                    print(_listServices[index].id);
                    return Card(
                      child: ListTile(
                        title: Text(_listServices[index].title!),
                        subtitle: Text(
                            'Service ${localUser.principalServiceId == _listServices[index].id ? "principal" : "secondaire"}'),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: _listServices.length),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddServicesPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
