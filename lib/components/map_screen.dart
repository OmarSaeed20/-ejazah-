// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';

import 'package:ejazah/constants/constants.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../model/mapFunctions_model.dart';

class MapScreen extends StatefulWidget {
  bool checkCurrent;
  double? height;
  bool disableMarker;
  LatLng? latlong;
  String? AdsOwner;
  double? zoom;

  MapScreen({
    this.latlong,
    this.AdsOwner,
    this.checkCurrent = false,
    this.disableMarker = false,
    this.height,
    this.zoom,
    Key? key,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? latlong;
// get address from lat long
  Future<void> getLocationFromLatLong(lat, long) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat, long, localeIdentifier: 'ar');
      Placemark place = placemarks[0];

      setState(() {
        address =
            '${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.locality}, ${place.subLocality}, ${place.thoroughfare}, ${place.subThoroughfare}';
      });
      log("address ===> $address");
    } catch (error) {
      debugPrint('error in get current lat, lng ---> $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        widget.disableMarker == true
            ? Container(
                alignment: Alignment.center,
                width: size.width * 0.85,
                height: widget.height ?? 180.0,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  compassEnabled: true,
                  initialCameraPosition: _cameraPosition!,
                  markers: {
                    if (_origin != null) _origin!,
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController = (controller);

                    _googleMapController!.animateCamera(
                        CameraUpdate.newCameraPosition(_cameraPosition!));
                  },
                  onTap: _addMarker,
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: size.width,
                height: widget.height ?? 180.0,
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: _cameraPosition!,
                  markers: {
                    if (_origin != null) _origin!,
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController = (controller);

                    _googleMapController!.animateCamera(
                        CameraUpdate.newCameraPosition(_cameraPosition!));
                  },
                  onTap: _addMarker,
                ),
              ),
        SizedBox(height: 1.0.h),
        widget.checkCurrent == true
            ? TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 6.h),
                ),
                onPressed: () async {
                  Position currentPosition =
                      await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                  latlong = new LatLng(
                      currentPosition.latitude, currentPosition.longitude);
                  AddAdsController.lat = latlong!.latitude.toString();
                  AddAdsController.long = latlong!.longitude.toString();
                  getLocationFromLatLong(latlong!.latitude, latlong!.longitude);
                  _addMarker(latlong!);

                  _googleMapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: latlong!,
                        zoom: widget.zoom ?? 18,
                        tilt: 0,
                      ),
                    ),
                  );
                },
                child: const Text('اختر موقعك الحالي'),
              )
            : Container(),
      ],
    );
  }

  @override
  void initState() {
    latlong = new LatLng(0, 0);
    _cameraPosition = CameraPosition(target: latlong!, zoom: widget.zoom ?? 18);
    if (widget.latlong != null) _addMarker(widget.latlong!);
    if (widget.latlong != null)
      _cameraPosition =
          CameraPosition(target: widget.latlong!, zoom: widget.zoom ?? 18);
    _determinePosition();
    super.initState();
  }

  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  CameraPosition? _cameraPosition;
  GoogleMapController? _googleMapController;
  Marker? _origin;

  void _addMarker(LatLng pos) {
    if (widget.latlong != null && widget.AdsOwner != null) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId(widget.AdsOwner!),
          infoWindow: InfoWindow(title: widget.AdsOwner),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: widget.latlong!,
        );
        getLocationFromLatLong(
          double.parse(MapClass.latitude!),
          double.parse(MapClass.longitude!),
        );
        log("'new lat'${MapClass.latitude}");
        log("'new lng'${MapClass.longitude}");
      });
      return;
    }
    if (_origin != null) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: InfoWindow(title: 'Current'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          flat: true,
          position: pos,
        );

        AddAdsController.lat = pos.latitude.toString();
        AddAdsController.long = pos.longitude.toString();
        MapClass.latitude = pos.latitude.toString();
        MapClass.longitude = pos.longitude.toString();
      });
    } else {
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: InfoWindow(title: 'current'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        AddAdsController.lat = pos.latitude.toString();
        AddAdsController.long = pos.longitude.toString();
        getLocationFromLatLong(pos.latitude, pos.longitude);
        log("'new lat'${MapClass.latitude}");
        log("'new lng'${MapClass.longitude}");
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (_googleMapController != null)
      _googleMapController!
          .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition!));
    setState(() {
      MapClass.latitude = currentPosition.latitude.toString();
      MapClass.longitude = currentPosition.longitude.toString();
      log("'init'${MapClass.latitude}");
      log("'init'${MapClass.longitude}");
      print(widget.latlong);
      if (widget.latlong == null) {
        latlong =
            new LatLng(currentPosition.latitude, currentPosition.longitude);
        _cameraPosition =
            CameraPosition(target: latlong!, zoom: widget.zoom ?? 18);
        if (_googleMapController != null)
          _googleMapController!
              .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition!));
        print(latlong);
        _addMarker(latlong!);
      } else {
        latlong = widget.latlong;
        _cameraPosition =
            CameraPosition(target: latlong!, zoom: widget.zoom ?? 18);
        if (_googleMapController != null)
          _googleMapController!
              .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition!));
        _addMarker(latlong!);
      }
    });
    return currentPosition;
  }
}
