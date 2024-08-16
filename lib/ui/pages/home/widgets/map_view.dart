import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zebra/ui/pages/home/widgets/map_view_controller.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MapViewController(),
      global: false,
      builder: (controller) {
        return GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          rotateGesturesEnabled: true,
          mapToolbarEnabled: true,
          initialCameraPosition: controller.kGooglePlex,
          onMapCreated: controller.onMapCreated,
        );
      },
    );
  }
}
