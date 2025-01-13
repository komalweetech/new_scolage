import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../dashboard/view/screen/dashboard_screen.dart';
import '../../../dashboard/view/widget/simple_common_appbar.dart';
import '../../services/AppliedCollegesApi.dart';

class AppliedColleges extends StatefulWidget {
  const AppliedColleges({super.key});

  @override
  State<AppliedColleges> createState() => _AppliedCollegesState();
}

class _AppliedCollegesState extends State<AppliedColleges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(100 + MediaQuery.of(context).padding.top),
        child: const SimpleCommonAppBar(),
      ),
      body: FutureBuilder(
        future: AppliedCollegesApi.getAppliedApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading while fetching data
          }

          // Handle errors
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "There is an error loading the applied colleges.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
            );
          }
          if (snapshot.hasData) {
            var data = snapshot.data as List<dynamic>;
            print("applied data == $data");

            if (data.isEmpty) {
              // Show the empty image when no data is present
              return  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                      child: Image.asset(AssetIcons.NoAnyDataPNG,),
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      "Not applied any collages",
                      style: TextStyle(
                        fontSize: 25.sp,
                      ),
                    ),
                    Text(
                      "Start searching for colleges now",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(
                              128, 128, 128, 1)),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(DashboardScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "Explore junior colleges",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 100,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) => Card(
                      color: kSecondPrimaryColor,
                      elevation: 4,
                      // Elevation adds a shadow below the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Application id : ${data[index]["student_detail"][0]["_id"]}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: grey88Color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'College Name : ${data[index]["college"][0]["collegename"]}',
                              style: const TextStyle(
                                  color: grey88Color, fontSize: 15),
                            ),
                            Text(
                              'Student Name : ${data[index]["student_detail"][0]["name"]}',
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: grey88Color,
                              ),
                            ),
                            Text(
                              'Email : ${data[index]["studentname"][0]["email"]}',
                              style: const TextStyle(
                                  color: grey88Color, fontSize: 15),
                            ),
                            Text(
                              'Course Name : ${data[index]["course"][0]["subjectname"]}',
                              style: const TextStyle(
                                  color: grey88Color, fontSize: 15),
                            ),
                            // Text(
                            //   appliedClgData[index]["studentname"][index]["phone"].toInt,
                            //   textAlign: TextAlign.center,
                            // ),
                            Text(
                              'Application Status : ${data[index]["status"]}',
                              style: const TextStyle(
                                  color: grey88Color, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                  ),
                ),
              ],
            );
          }else {
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                    child: Image.asset(AssetIcons.NoAnyDataPNG,),
                  ),
                  SizedBox(height: 20.h,),
                  Text(
                    "Not applied any colleges",
                    style: TextStyle(
                      fontSize: 25.sp,
                    ),
                  ),
                  Text(
                    "Start searching for colleges now",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color.fromRGBO(
                            128, 128, 128, 1)),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      Get.to(DashboardScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "Explore junior colleges",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
