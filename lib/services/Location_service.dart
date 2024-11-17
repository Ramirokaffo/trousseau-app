import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../UniversalFunction/UniversalSnackBar.dart';


class LocationService {

  static late Position _currentPosition;

  static Future<Position?> getCurrentLocation(BuildContext context) async {
    await Geolocator.isLocationServiceEnabled().then((bool serviceEnabled) async {
      print("serviceEnabled: $serviceEnabled");
      if (!serviceEnabled) {
        showUniversalSnackBar(context: context, message: "Le service de localisation n'est pas activé sur votre appareil");
        return null;
      } else {
        await Geolocator.checkPermission().then((LocationPermission permissionGranted) async {
          print("permissionGranted: $permissionGranted");
          if (permissionGranted == LocationPermission.denied) {
             await Geolocator.requestPermission().then((LocationPermission value) {
               // print("value: ");
               permissionGranted = value;
              if (permissionGranted == LocationPermission.denied) {
                showUniversalSnackBar(context: context, message: "Nous n'avons pas pu déterminer votre position");
                return null;
              }
            });
             // return _currentPosition;
          }
          _currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          // Geolocator.
          print(_currentPosition.latitude);
          print(_currentPosition.longitude);
          // return _currentPosition;
        });
      }
    });
    return _currentPosition;
  }

  static void getUserAddress() async {
    print("Ici dedans");
    // DeliveryAddress deliveryAddress = DeliveryAddress();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _currentPosition.latitude,
      _currentPosition.longitude,
    );
    Placemark placemark = placemarks[0];
    print("Ici aussi");

    // deliveryAddress.long = _currentPosition.longitude;
    // deliveryAddress.lat = _currentPosition.latitude;
    // deliveryAddress.country = placemark.country;
    // deliveryAddress.city = placemark.locality;
    // deliveryAddress.region = placemark.administrativeArea;
    // deliveryAddress.street = placemark.street;
    // deliveryAddress.isValid = true;

    print("placemark.subAdministrativeArea: ${placemark.subAdministrativeArea}");
    print("placemark.subLocality: ${placemark.subLocality}");
    print("placemark.subThoroughfare: ${placemark.subThoroughfare}");

    // return deliveryAddress;
  }
}


