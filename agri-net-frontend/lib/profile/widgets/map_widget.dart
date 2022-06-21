import '../../libs.dart';

class MapView extends StatelessWidget {
  final double lat;
  final double lon;
  final String title;
  MapView(this.lat, this.lon, {required this.title});

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  @override
  Widget build(BuildContext context) {
    LatLng target = LatLng(lat, lon);
    CameraPosition cameraPosition = CameraPosition(target: target, zoom: 2.0);
    final Set<Marker> markers = new Set();
    markers.add(Marker(
      markerId: MarkerId(target.toString()),
      position: target, //position of marker
      infoWindow: InfoWindow(
        title: this.title,
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    return MapPicker(
      iconWidget: Icon(
        Icons.location_pin,
        color: Colors.red,
        size: 30,
      ),
      //add map picker controller
      mapPickerController: mapPickerController,
      child: GoogleMap(
        markers: markers,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        // hide location button
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        //  camera position
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMoveStarted: () {
          mapPickerController.mapMoving!();
        },
        onCameraIdle: () async {
          mapPickerController.mapFinishedMoving!();
          List<Placemark> placemarks = await placemarkFromCoordinates(
            cameraPosition.target.latitude,
            cameraPosition.target.longitude,
          );
        },
      ),
    );
  }
}
