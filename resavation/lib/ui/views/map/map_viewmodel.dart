import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/maps_direction_model.dart';
import 'package:resavation/ui/views/map/widgets/direction_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MapViewModel extends BaseViewModel {
  final String googleAPIKey = "AIzaSyBRB6De8wyZ4RhQ_bBkZ2eTggtMunOWL5Y";

  late GoogleMapController googleMapController;
  Marker? origin;
  Marker? destination;
  Directions? info;

  // initial camera position
  final CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(6.465422, 3.406448), zoom: 11.5);

  // to add marker on the map
  void addMarker(LatLng pos) async {
    if (origin == null || (origin != null && destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      // Reset destination
      destination = null;

      // Reset info
      info = null;
      print("1st info is $info");
      notifyListeners();
    } else {
      // Origin is already set
      // Set destination
      destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: origin!.position, destination: pos);
      info = directions;
      print("2st info is $info");
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }
}
