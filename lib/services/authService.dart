import 'package:firebase_auth/firebase_auth.dart';

import '../models/userModel.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signInAnonymous() async {
    try {
      final result = await auth.signInAnonymously();
      print(result.user);
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // void sendVerificationMail(String email) {
  //   auth.sendSignInLinkToEmail(email: email, actionCodeSettings: ActionCodeSettings(url: url))
  // }

  // Future signUp(UserModel userParam) async {
  //   try {
  //     final result = await auth.createUserWithEmailAndPassword(email: userParam.email!, password: userParam.password);
  //     final user = result.user;
  //     UserModel myUser = UserModel(id: user!.uid, email: email,
  //         firstName: user.firstName, lastName: lastName,
  //         phoneNumber: phoneNumber, whatsappNumber: whatsappNumber);
  //     if (user != null) {
  //       await DBService().saveUser(myUser);
  //     }
  //   } catch (e) {
  //
  //   }
  // }

  Future signIn(String email, password, firstName, {String? lastName}) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
    } catch (e) {}
  }

  static User? get user {
    return FirebaseAuth.instance.currentUser;
  }
}
