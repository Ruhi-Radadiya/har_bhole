import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var currentAddress = "Fetching location...".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    try {
      isLoading.value = true;

      // ✅ Request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // ✅ Get current position
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // ✅ Get detailed placemark info
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        Placemark place = placemarks.first;

        // ✅ Construct a detailed address
        currentAddress.value = [
          // place.name, // e.g. "442, Raj Imperia"
          place.subLocality, // e.g. "Vraj Chowk"
          place.locality, // e.g. "Surat"
          place.administrativeArea, // e.g. "Gujarat"
          // place.postalCode, // e.g. "395006"
        ].where((element) => element != null && element.isNotEmpty).join(', ');
      } else {
        currentAddress.value = "Location permission denied";
      }
    } catch (e) {
      currentAddress.value = "Error getting location";
      print("Error getting location: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
