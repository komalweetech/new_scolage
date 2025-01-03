import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/apiData/api_base_port.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import 'full_screen_image.dart';

class GalleryViewScreen extends StatefulWidget {
  final String clgId;

  const GalleryViewScreen({super.key, required this.clgId});

  @override
  _GalleryViewScreenState createState() => _GalleryViewScreenState();
}

class _GalleryViewScreenState extends State<GalleryViewScreen> {
  List<String> imageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImages();
    print("clg id == ${widget.clgId}");
  }

  Future<void> fetchImages() async {
    String apiUrl =
        "http://192.168.29.70:7001/collegeImages/fetchCollegeImage/${widget.clgId}";
    print("get image url == $apiUrl");
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        print("jason response == ${jsonResponse['data']}");

        if (jsonResponse['success'] == true) {
          setState(() {
            imageUrls = List<String>.from(jsonResponse['data']);
            isLoading = false;
          });
          print("image urls == $imageUrls");
        } else {
          print('else part');
          throw Exception("API returned success = false");
        }
      } else {
        throw Exception(
            "API call failed with status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching images: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100.r),
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  AssetIcons.NEARBY_SCREEN_BACK_ARROW_ICON,
                  height: 17.h,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        title: const Text(
          "All Images",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 15,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 5 : 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(FullScreenImage(images: imageUrls, initialIndex: index));
                    },
                    child: CachedNetworkImage(
                      imageUrl: imageUrls[index],
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
