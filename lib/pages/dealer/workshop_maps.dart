import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class WorkshopMaps extends StatefulWidget {
  WorkshopMaps(this.latitudeCoordinate, this.longitudeCoordinate, {super.key});

  double latitudeCoordinate;
  double longitudeCoordinate;

  @override
  State<WorkshopMaps> createState() => _WorkshopMapsState();
}

class _WorkshopMapsState extends State<WorkshopMaps> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // print(GlobalVar.latitudeList[widget.latitudeIndex]);
    // print(GlobalVar.longitutdeList[widget.longitudeIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: const Color(0xFF99CCFF),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          width: 15.0,
          height: 15.0,
          margin: const EdgeInsets.only(top: 10.0, left: 10.0),
          padding: const EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            //replace with our own icon data.
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(
                widget.latitudeCoordinate,
                widget.longitudeCoordinate,
              ),
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.stsj.fixupmotoapps',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(
                      widget.latitudeCoordinate,
                      widget.longitudeCoordinate,
                    ), // Replace with desired coordinates
                    builder: (ctx) => const Icon(
                      // Icons.pin_drop_rounded,
                      Icons.location_on_rounded,
                      color: Colors.black,
                      size: 50.0,
                    ),
                  ),
                  // Add more markers as needed using the same structure
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
