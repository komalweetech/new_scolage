import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../model/map_college_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final List<mapCollegeModel> colleges = [
    mapCollegeModel(name: 'College A', latitude: 20.5937, longitude: 78.9629, city: 'City A'),
    mapCollegeModel(name: 'College B', latitude: 19.0760, longitude: 72.8777, city: 'Mumbai'),
    mapCollegeModel(name: 'College C', latitude: 24.879999, longitude: 74.629997, city: 'Rajasthan'),
    mapCollegeModel(name: 'College D', latitude: 16.166700, longitude: 74.833298, city: 'karnataka'),
    mapCollegeModel(name: 'College E', latitude: 28.679079, longitude: 77.069710, city: 'Delhi'),
    mapCollegeModel(name: 'College F', latitude: 26.850000, longitude: 80.949997, city: 'Utter Pradesh'),
    mapCollegeModel(name: 'College G', latitude: 26.540457, longitude: 88.719391, city: 'West bengal'),
    mapCollegeModel(name: 'College H', latitude: 24.882618, longitude: 72.858894, city: 'Sirohi'),
    mapCollegeModel(name: 'College I', latitude: 22.728392, longitude: 71.637077, city: 'SurendraNager'),
    mapCollegeModel(name: 'College J', latitude: 12.715035, longitude: 77.281296, city: 'City B'),
    mapCollegeModel(name: 'College K', latitude: 16.779877, longitude: 74.556374, city: 'City B'),
    mapCollegeModel(name: 'College L', latitude: 13.432515, longitude: 77.727478, city: 'City B'),
    mapCollegeModel(name: 'College M', latitude: 12.651805, longitude: 77.208946, city: 'City B'),
    mapCollegeModel(name: 'College N', latitude: 9.383452, longitude: 76.574059, city: 'City B'),
    mapCollegeModel(name: 'College O', latitude: 14.623801, longitude: 75.621788, city: 'City B'),
    mapCollegeModel(name: 'College P', latitude: 10.925440, longitude: 79.838005, city: 'City B'),
    mapCollegeModel(name: 'College Q', latitude: 15.852792, longitude: 74.498703, city: 'City B'),
    mapCollegeModel(name: 'College R', latitude: 19.354979, longitude: 84.986732, city: 'City B'),
    mapCollegeModel(name: 'College S', latitude: 23.905445, longitude: 87.524620, city: 'City B'),
    mapCollegeModel(name: 'College T', latitude: 20.296059, longitude: 85.824539, city: 'City B'),
    mapCollegeModel(name: 'College U', latitude: 21.105001, longitude: 71.771645, city: 'City B'),
    mapCollegeModel(name: 'College V', latitude: 30.172716, longitude: 77.299492, city: 'City B'),
    mapCollegeModel(name: 'College W', latitude: 25.477585, longitude: 85.709091, city: 'City B'),
    mapCollegeModel(name: 'College X', latitude: 21.045521, longitude: 75.801094, city: 'City B'),
    mapCollegeModel(name: 'College Y', latitude: 26.491890, longitude: 89.527100, city: 'City B'),
    mapCollegeModel(name: 'College Z', latitude: 8.893212, longitude: 76.614143, city: 'City B'),
    mapCollegeModel(name: 'College A', latitude: 25.989836, longitude: 79.450035, city: 'City B'),
    mapCollegeModel(name: 'College B', latitude: 30.525005, longitude: 75.890121, city: 'City B'),
    mapCollegeModel(name: 'College C', latitude: 28.590361, longitude: 78.571762, city: 'City B'),
    mapCollegeModel(name: 'College D', latitude: 29.854263, longitude: 77.888000, city: 'City B'),
    mapCollegeModel(name: 'College E', latitude: 32.041943, longitude: 75.405334, city: 'City B'),
  ];

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _initialPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.from(
            colleges.map((college) {
                if(college.latitude != null && college.longitude != null) {
                  return Marker(
                    markerId: MarkerId(college.name),
                    position: LatLng(college.latitude!, college.longitude!),
                    infoWindow: InfoWindow(title: college.name),
                  );
                } else {
                  return Marker(
                    markerId: MarkerId(college.name),
                    position: const LatLng(0, 0),
                    infoWindow: InfoWindow(title: college.name),
                  );
                }
            }),
          ),
        ),
        Positioned(
          bottom: 30.h,
          left: MediaQuery.of(context).size.width / 2.5,
          right: MediaQuery.of(context).size.width / 2.5,
          child: Material(
            color: Colors.black,
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              // borderRadius: BorderRadius.circular(100),
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 08.h, horizontal: 12.w),
                child: Row(
                  children: [
                    const Icon(
                      Icons.format_list_bulleted_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "List",
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}


