import 'dart:async';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_marker_animation/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import '../parent_model/coordinates_model.dart' as data;

import 'dart:io' show Platform;
import '../utility/helper_widget.dart';
import 'back_button.dart';
import 'logout_button.dart';


class MapScreenSchool extends StatefulWidget {
  int trackId;
  data.Data locations;
  BitmapDescriptor green;
  BitmapDescriptor red;
  BitmapDescriptor orange;

  MapScreenSchool(
      {Key? key,
        required this.locations,
        required this.trackId,
        required this.orange,
        required this.green,
        required this.red})
      : super(key: key);

  @override
  _MapScreenSchoolState createState() => _MapScreenSchoolState();
}

class _MapScreenSchoolState extends State<MapScreenSchool> {
  final String key = "AIzaSyBhN7K2pQYAlxY7bQlqzSf6YUpLKkBhLrI";
  Completer<GoogleMapController> _controller = Completer();
  MapPickerController mapPickerController = MapPickerController();

  List<MapType> mapType = [
    MapType.normal,
    MapType.satellite,
  ];
  int mapIndex = 0;

  late GoogleMapController _googleMapController;
  late CameraPosition _cameraPosition;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.7041, 77.1025),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 0,
      target: LatLng(28.7041, 77.1025),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  late Position _currentPosition;

  _getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(double.parse(widget.locations.latitude.toString()),
            double.parse(widget.locations.longitude.toString())),
        zoom: 17.151926040649414)));
    Timer(Duration(seconds: 1), () { controller.showMarkerInfoWindow(MarkerId('SomeId'));});

  }

  _getAddress() async {
    List<Placemark> p = await placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);

    Placemark place = p[0];

    setState(() {
      ///current address
    });
  }

  List<Marker> customMarkers = [];
  List<Marker> _markers = [];
  late BitmapDescriptor myIcon;

  @override
  void initState() {

    BitmapDescriptor icon;
    if (widget.locations.speed == 0 && widget.locations.ignition == false) {
      icon = widget.red;
    } else if (widget.locations.speed == 0 &&
        widget.locations.ignition == true) {
      icon = widget.orange;
    } else {
      icon = widget.green;
    }
    _markers.add(Marker(
        rotation: widget.locations.direction!.toDouble(),
        markerId: MarkerId('SomeId'),
        icon: icon,

        position: LatLng(double.parse(widget.locations.latitude.toString()),
            double.parse(widget.locations.longitude.toString())),
        // infoWindow: InfoWindow(
        //     snippet: widget.locations.registrationNumber.toString() +
        //         "" +
        //         widget.locations.driverName.toString()+", ${getTime(widget.locations.timestamp?.split(" ")[1]??"")}, ${getFormat(widget.locations.timestamp??"")}",
        //     title: "Speed : " + widget.locations.speed.toString())
    )
    );

    _cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    _getCurrentLocation();
    getLocationUpdate();
    // TODO: implement initState
    super.initState();
  }

  void getLocationUpdate() async {
    final GoogleMapController controller = await _controller.future;
    Timer(Duration(seconds: 10), () {
      ParentController()
          .getCoordinatesByDeviceIdWSM(id: widget.trackId.toString(),navigate: false)
          .then((value) {
        widget.locations = value;
        BitmapDescriptor icon;
        _markers.clear();
        if (widget.locations.speed == 0 &&
            widget.locations.ignition == false) {
          icon = widget.red;
        } else if (widget.locations.speed == 0 &&
            widget.locations.ignition == true) {
          icon = widget.orange;
        } else {
          icon = widget.green;
        }
        _markers.add(Marker(
            markerId: MarkerId('SomeId'),
            rotation: widget.locations.direction!.toDouble(),
            icon: icon,
            position: LatLng(double.parse(widget.locations.latitude.toString()),
                double.parse(widget.locations.longitude.toString())),
        ));
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            bearing: 0,
            target: LatLng(double.parse(widget.locations.latitude.toString()),
                double.parse(widget.locations.longitude.toString())),
            zoom: 17.151926040649414)));
          setState(() {});
          getLocationUpdate();
      });
    });
  }

  void forceUpdate() async {
    showLoader();
    final GoogleMapController controller = await _controller.future;

    ParentController()
        .getCoordinatesByDeviceIdWSM(id: widget.trackId.toString(),navigate: false)
        .then((value) {
      widget.locations = value;
      BitmapDescriptor icon;
      _markers.clear();
      if (widget.locations.speed == 0 &&
          widget.locations.ignition == false) {
        icon = widget.red;
      } else if (widget.locations.speed == 0 &&
          widget.locations.ignition == true) {
        icon = widget.orange;
      } else {
        icon = widget.green;
      }
      _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        rotation: widget.locations.direction!.toDouble(),
        icon: icon,
        position: LatLng(double.parse(widget.locations.latitude.toString()),
            double.parse(widget.locations.longitude.toString())),
      ));
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0,
          target: LatLng(double.parse(widget.locations.latitude.toString()),
              double.parse(widget.locations.longitude.toString())),
          zoom: 17.151926040649414)));
      hideLoader();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    myLog(label: "important", value: _markers.last.markerId.value);
    return Scaffold(
      //key: UserController.key,
      body: SafeArea(
        child: Stack(
          children: [
            Animarker(
              duration: Duration(milliseconds: 2000),
              mapId: _controller.future.then<int>((value) => value.mapId),
              zoom: 17.151926040649414,
              markers: <Marker>{
                Marker(
                  markerId: MarkerId(_markers.last.markerId.value),
                  onTap: _markers.last.onTap,
                  position: _markers.last.position,
                  icon: _markers.last.icon,
                  rotation: _markers.last.rotation,
                  infoWindow: _markers.last.infoWindow,
                ),
              },
              child: GoogleMap(
                rotateGesturesEnabled: false,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                mapType: mapType[mapIndex],
                // markers: Set<Marker>.of(_markers),
                compassEnabled: false,
                //myLocationEnabled: true,
                // myLocationButtonEnabled: false,
                //zoomControlsEnabled: false,

                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {},
                onCameraMove: (cameraPosition) {
                  this._cameraPosition = cameraPosition;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyBackButton(),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      LogoutButton(),
                      smallSpace(),
                      InkWell(
                        onTap: () {
                          if (mapIndex == (mapType.length - 1)) {
                            mapIndex = 0;
                          } else {
                            mapIndex += 1;
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: .6,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Icon(
                            Icons.layers_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      smallSpace(),
                      InkWell(
                        onTap: () {
                          forceUpdate();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: .6,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Icon(
                            Icons.refresh,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 0,
                  target: LatLng(
                      double.parse(widget.locations.latitude.toString()),
                      double.parse(
                          widget.locations.longitude.toString())),
                  zoom: 17.151926040649414)));
          setState(() {});
        },
        child: Icon(Icons.location_searching),
      )
          : Container(),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
