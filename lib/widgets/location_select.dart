/*

import 'dart:async';

import 'package:fancyin/configurations.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelect extends StatefulWidget {
  LocationSelect({super.key, this.latLng, required this.onChange});

  final LatLng? latLng;
  final Function(LatLng, String) onChange;

  @override
  _LocationSelectState createState() => _LocationSelectState();
}

class _LocationSelectState extends State<LocationSelect> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          trafficEnabled: false,
          mapToolbarEnabled: false,
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          indoorViewEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          rotateGesturesEnabled: false,
          initialCameraPosition: CameraPosition(
            target: widget.latLng ?? LatLng(39.129033, 35.471636),
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              _mapController = controller;
            });
            _controller.complete(controller);
          },
          markers: widget.latLng != null
              ? Set.of([
                  Marker(
                    markerId: MarkerId("selectedMarker"),
                    position: LatLng(
                      widget.latLng.latitude,
                      widget.latLng.longitude,
                    ),
                  )
                ])
              : null,
        ),
        Positioned.fill(
          child: Container(
            color:
                widget.latLng == null ? Color(0xEEFFFFFF) : Color(0x00FFFFFF),
            child: FlatButton(
              child: widget.latLng == null
                  ? Text(
                      "Konum seçmek için tıklayınız...",
                      style: TextStyle(
                        color: Color(0xFF737373),
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : Container(),
              onPressed: () async {
                LocationResult result = await showLocationPicker(
                  context,
                  MAPS_API_KEY,
                  countries: ['TR'],
                );

                if (result != null) {
                  widget.onChange(result.latLng, result.address);
                  _mapController.animateCamera(
                      CameraUpdate.newLatLngZoom(result.latLng, 17));
                }

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PlacePicker(
                //       apiKey: MAPS_API_KEY,
                //       onPlacePicked: (result) {
                //         print(result);
                //         Navigator.of(context).pop();
                //       },
                //       onGeocodingSearchFailed: (a) {
                //         print(a);
                //       },
                //       initialPosition: _startPosition.target,
                //       useCurrentLocation: true,
                //       usePlaceDetailSearch: false,
                //       usePinPointingSearch: false,
                //       enableMapTypeButton: false,
                //       forceAndroidLocationManager: false,
                //     ),
                //   ),
                // );
              },
            ),
          ),
        )
      ],
    );
  }
}
*/