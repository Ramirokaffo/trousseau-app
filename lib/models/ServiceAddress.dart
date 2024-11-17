class ServiceAddress {
  late int? id;
  late String? country;
  bool? isValid = false;
  late String? region;
  late String? street;
  late String? city;
  late double? long;
  late double? lat;
  late String? precision;

  ServiceAddress(
      {this.id,
      this.country,
      this.isValid,
      this.city,
      this.region,
      this.street,
      this.long,
      this.lat,
      this.precision});

  ServiceAddress.fromMap(Map<String, dynamic> deliveryAddress) {
    id = deliveryAddress["id"];
    country = deliveryAddress["country"];
    region = deliveryAddress["region"];
    street = deliveryAddress["street"];
    city = deliveryAddress["city"];
    long = deliveryAddress["long"];
    lat = deliveryAddress["lat"];
    precision = deliveryAddress["precision"];
  }

  Map<String, dynamic> toSendMapDto() {
    return {
      "country": country,
      "region": region,
      "street": street,
      "city": city,
      "precision": precision,
      "long": long,
      "lat": lat,
    };
  }
}
