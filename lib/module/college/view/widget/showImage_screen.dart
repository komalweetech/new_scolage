// import 'package:flutter/material.dart';
//
//
// class CountryPage extends StatefulWidget {
//   final Country country;
//   final List<Destiny> destinies;
//   const CountryPage({
//     Key? key,
//     required this.country,
//     required this.destinies,
//   }) : super(key: key);
//
//   @override
//   _CountryPageState createState() => _CountryPageState();
// }
//
// class _CountryPageState extends State<CountryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.network(widget.country.imageURL,fit: BoxFit.cover),
//         ],
//       ),
//     );
//   }
// }
// class Destiny {
//   final String countryId;
//   final String destiny;
//   final String imageURL;
//   final String? instulment;
//
//     const Destiny({
//       required this.countryId,
//       required this.destiny,
//       required this.imageURL,
//        this.instulment,
// });
// }
// class Country {
//   final String id;
//   final String name;
//   final String imageURL;
//   final int  attraction;
//   bool isMyFavourite;
//
//    Country({
//     required this.id,
//     required this.name,
//     required this.imageURL,
//     required this.attraction,
//     this.isMyFavourite = false,
//   });
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_scolage/module/college/view/widget/gallery_view_screen.dart';
import 'package:new_scolage/utils/theme/common_color.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class ShowImageScreen extends StatefulWidget {
  const ShowImageScreen({
    super.key,
    required this.clgImageList,
    required this.clgId,
  });

  final List<dynamic> clgImageList;
  final String clgId;

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  final List<dynamic> imageList = [];
  late String backgroundImage = '';

  void preloadImages() {
    for (var image in imageList) {
      precacheImage(NetworkImage(image["imageUrl"]), context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCollegeImages();
    WidgetsBinding.instance.addPostFrameCallback((_) => preloadImages());
  }

  void fetchCollegeImages() {
    List<dynamic> subList = widget.clgImageList;

    print("show image List ==== $subList}");

    for (var i = 0; i < subList.length; i++) {
      if (subList[i]["collegeid"] == widget.clgId) {
        imageList.add({
          "imageUrl": subList[i]["imageUrl"],
          "imageName": subList[i]["name"],
        });

        print("show only image == $imageList");
        print("show clg id = ${widget.clgId}");
        print("show clg id = ${subList[i]["collegeid"]}");
      }
    }
    if (imageList.isNotEmpty) {
      setState(() {
        backgroundImage = imageList.first["imageUrl"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundImage.isNotEmpty) ...[
            PanoramaViewer(
              child: Image.network(
                backgroundImage,
                height: 200 * MediaQuery.of(context).devicePixelRatio,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ],
          Positioned(
            bottom: 50.h,
            left: 15.w,
            right: 10.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 115.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return buildThumbnail(imageList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildThumbnail(Map<String, dynamic> imageData) {
    String imageUrl = imageData["imageUrl"];
    String imageName = imageData["imageName"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
          onTap: () {
            setState(() {
              backgroundImage = imageUrl;
            });
          },
          child: Container(
            height: 95.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius:5,
                        offset:
                            const Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 95.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: 150.w,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                // SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                      width: 80.w,
                      // height: 20.h,
                      child: Text(
                        imageName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: "Poppins",
                        ),
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          )),
    );
  }
}
