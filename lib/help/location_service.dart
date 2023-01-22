import 'dart:async';
import 'package:location/location.dart';



class LocationService {
  UserLocation? currentLocation;
  Location location = Location();
  final StreamController<UserLocation> locationController = StreamController<UserLocation>.broadcast();

   LocationService(){
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.changeSettings(interval: 5000);
        location.onLocationChanged.listen((locationData) {
          locationController.add(UserLocation(
            latitude: locationData.latitude,
            longitude: locationData.longitude,
            heading: locationData.heading
          ));
        });
      }
    });
  }


  Stream<UserLocation> get locationStream => locationController.stream;
  Future<UserLocation?> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
        heading: userLocation.heading
      );
    } catch (e) {
      print('Could not get the location: $e');
    }
    return currentLocation;
  }
}


class UserLocation {
  final double? latitude;
  final double? longitude;
  final double? heading;
  UserLocation({this.latitude, this.longitude,this.heading});
}