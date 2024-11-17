import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:trousseau/models/userModel.dart';

class DBService {
  static final CollectionReference usercol =
      FirebaseFirestore.instance.collection("users");
  static late UserModel localUser;

  Future saveUser(UserModel user) async {
    try {
      await usercol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      final result = await usercol.doc(userId).get();
      UserModel user =
          UserModel.fromJson(result.id, result.data() as Map<String, dynamic>);
      return user;
    } catch (e) {}
    return null;
  }

  static Future<UserModel?> getLocalUser() async {
    try {
      localUser.firstName;
      return localUser;
    } catch (e) {
      try {
        final result =
            await usercol.doc(FirebaseAuth.instance.currentUser!.uid).get();
        localUser = UserModel.fromJson(
            result.id, result.data() as Map<String, dynamic>);
        return localUser;
      } catch (e) {
        return null;
      }
    }
  }

  Future updateUser(UserModel user) async {
    try {
      final result = await usercol.doc(user.id).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future uploadImage(File file, {required String path}) async {
    var time = DateTime.now().toString();
    String ext = Path.basename(file.path).split(".")[1].toString();

    String image = "$path$time.$ext";
    try {
      Reference ref = FirebaseStorage.instance.ref().child("$path/$image");
      UploadTask upload = ref.putFile(file);
      await upload.whenComplete(() => {});
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
