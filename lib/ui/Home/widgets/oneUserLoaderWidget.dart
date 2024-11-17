import 'package:flutter/material.dart';
import 'package:trousseau/services/DBService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../Enumeration/fetchStatus.dart';
import '../../../models/userModel.dart';

class OneUserLoaderWidget extends StatefulWidget {
  const OneUserLoaderWidget({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  State<OneUserLoaderWidget> createState() => _OneUserLoaderWidgetState();
}

class _OneUserLoaderWidgetState extends State<OneUserLoaderWidget> {
  // bool _isLoading = true;
  FetchStatus _fetchStatus = FetchStatus.fetching;
  late UserModel user;
  void loadUser() async {
    DBService().getUser(widget.userId).then((UserModel? myUser) {
      if (myUser != null) {
        user = myUser;
        _fetchStatus = FetchStatus.success;
      } else {
        _fetchStatus = FetchStatus.anErrorOccur;
      }
      setState(() {});
    }).onError((error, stackTrace) {
      setState(() {
        _fetchStatus = FetchStatus.anErrorOccur;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return (_fetchStatus == FetchStatus.fetching)
        ? const LinearProgressIndicator()
        : Card(
            child: ListTile(
              leading: const Icon(
                Icons.account_circle_rounded,
                size: 50,
              ),
              title: Text("${user.lastName!} ${user.firstName!}"),
              subtitle: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: () async {
                        final link = WhatsAppUnilink(
                          phoneNumber: "+237${user.whatsappNumber!}",
                          text: "Salut ! J'aimerais...",
                        );
                        await launchUrl(link.asUri());
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primary),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                      child: Row(
                        children: [
                          Icon(Icons.message_outlined,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                          const SizedBox(
                            width: 2,
                          ),
                          Text("WhatsApp",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary)),
                        ],
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        final Uri telLaunchUri = Uri(
                          scheme: 'tel',
                          path: user.phoneNumber!,
                        );
                        await launchUrl(telLaunchUri);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primary),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                      child: Row(
                        children: [
                          Icon(Icons.call,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                          const SizedBox(
                            width: 2,
                          ),
                          Text("Appeler",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary)),
                        ],
                      )),
                ],
              ),
            ),
          );
  }
}
