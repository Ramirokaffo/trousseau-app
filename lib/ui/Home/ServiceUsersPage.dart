import 'package:flutter/material.dart';
import 'package:trousseau/models/ServicesModel.dart';
import 'package:trousseau/ui/Home/widgets/oneUserLoaderWidget.dart';

class ServiceUsersPage extends StatefulWidget {
  const ServiceUsersPage({Key? key, required this.service}) : super(key: key);
  final ServicesModel service;
  @override
  State<ServiceUsersPage> createState() => _ServiceUsersPageState();
}

class _ServiceUsersPageState extends State<ServiceUsersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.title!),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return OneUserLoaderWidget(
                userId: widget.service.listUsersId![index],
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: widget.service.listUsersId!.length),
      ),
    );
  }

  // void
}
