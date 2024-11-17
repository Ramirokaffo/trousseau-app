class UserModel {
  late String? id,
      email,
      firstName,
      lastName,
      phoneNumber,
      whatsappNumber,
      principalServiceId,
      profilImage;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.profilImage,
      this.phoneNumber,
      this.whatsappNumber,
      this.principalServiceId,
      this.lastName});

  factory UserModel.fromJson(String uuid, Map<String, dynamic> data) =>
      UserModel(
          id: uuid,
          email: data["email"],
          phoneNumber: data["phoneNumber"],
          firstName: data["firstName"],
          profilImage: data["profilImage"],
          whatsappNumber: data["whatsappNumber"],
          principalServiceId: data["principalServiceId"],
          lastName: data["lastName"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "profilImage": profilImage,
      "phoneNumber": phoneNumber,
      "whatsappNumber": whatsappNumber,
      "principalServiceId": principalServiceId,
    };
  }
}
