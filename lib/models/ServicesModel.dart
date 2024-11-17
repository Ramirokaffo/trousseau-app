import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicesModel {
  late String? id, title, description, addBy;
  late Timestamp? createAt;
  late Timestamp? deleteAt;
  late List<String>? listUsersId = [];
  static final CollectionReference servicesCollection =
      FirebaseFirestore.instance.collection("services");

  ServicesModel({
    this.id,
    this.title,
    this.description,
    this.createAt,
    this.deleteAt,
    this.addBy,
    this.listUsersId,
  });

  ServicesModel.fromMap(Map<String, dynamic> mapData, String myId) {
    print(mapData);
    id = myId;
    title = mapData["title"];
    description = mapData["description"];
    createAt = mapData["createAt"];
    addBy = mapData["addBy"];
    deleteAt = mapData["deleteAt"];
    listUsersId = mapData["listUsersId"] == null
        ? []
        : (mapData["listUsersId"] as List<dynamic>)
            .map((e) => e.toString())
            .toList();
  }

  Map<String, dynamic> toMap() {
    String? uuId = FirebaseAuth.instance.currentUser?.uid;
    return {
      "title": title,
      "description": description,
      "createAt": FieldValue.serverTimestamp(),
      "deleteAt": deleteAt,
      "addBy": uuId,
      "listUsersId": [uuId],
      "updateAt": FieldValue.serverTimestamp(),
    };
  }

  Future<bool> save() async {
    try {
      await servicesCollection.add(toMap()).then((documentSnapshot) {});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<ServicesModel>> getServices({int? limit}) async {
    return await servicesCollection
        .limit(limit ?? 50)
        .orderBy("title")
        .get()
        .then(
      (querySnapshot) {
        return querySnapshot.docs
            .map((e) =>
                ServicesModel.fromMap(e.data() as Map<String, dynamic>, e.id))
            .toList();
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  static Future<List<ServicesModel>> getUserServices({String? uuId}) async {
    uuId ??= FirebaseAuth.instance.currentUser?.uid;
    return await servicesCollection
        .where(
          "listUsersId",
          arrayContains: uuId,
        )
        .get()
        .then(
      (querySnapshot) {
        return querySnapshot.docs
            .map((e) =>
                ServicesModel.fromMap(e.data() as Map<String, dynamic>, e.id))
            .toList();
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<bool> addUser({String? uuId}) async {
    try {
      if (uuId == null) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          uuId = user.uid;
        }
      }
      // final CollectionReference usersCollection =
      // FirebaseFirestore.instance.collection("services");

      final myServiceRef = servicesCollection.doc(id);
      await myServiceRef.update({
        "listUsersId": FieldValue.arrayUnion([uuId]),
      }).then((value) {});

      return true;
    } catch (e) {
      return false;
    }
  }
}
