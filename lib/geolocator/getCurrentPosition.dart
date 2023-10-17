  import "package:geolocator/geolocator.dart";
  import "package:geocoding/geocoding.dart";

Future<Position>  getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location services are disabled.");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied");
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      "Location permissions are permanently denied, we cannot request permissions.");
  } 
  return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, String>> getKabupaten(double latitude, double langitude) async{
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, langitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String administrativeArea = placemark.administrativeArea ?? "Tidak Diketahui";
        String locality= placemark.locality ?? "Tidak Diketahui";
        String street = placemark.street ?? " Tidak Diketahui ";
        String country = placemark.country ?? " Tidak Diketahui ";
        return {
          "administrativeArea" :administrativeArea,
          "locality" :locality,
          "street" : street,
          "country" : country
        };
      }
    } catch (e) {
      return Future.error("Terjadi kesalahan yaitu $e");
    }
    return {"administrativeArea": "Tidak Diketahui", "locality": "Tidak Diketahui","street" : "Tidak Diketahui,"};
  }