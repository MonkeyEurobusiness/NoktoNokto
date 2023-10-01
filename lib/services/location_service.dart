import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationService {
  static LocationService? instance = null;
  static LocationService getInstance() {
    instance ??= LocationService._();
    return instance!;
  }

  LocationService._() {}

  Future<LatLng> getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return LatLng(50.06779728116886, 19.99146720652527);
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return LatLng(50.06779728116886, 19.99146720652527);
      }
    }

    _locationData = await location.getLocation();

    print(_locationData.latitude); // drukuje szerokość geograficzną
    print(_locationData.longitude); // drukuje długość geograficzną
    return LatLng(_locationData.latitude ?? 52.2297, _locationData.longitude ?? 21.0122);
  }
}
