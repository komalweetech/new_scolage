import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../dashboard/view/screen/dashboard_screen.dart';
import '../../../dashboard/view/widget/simple_common_appbar.dart';
import '../../services/AppliedCollegesApi.dart';

class ApprovedRejectedClg extends StatefulWidget {
  const ApprovedRejectedClg({super.key});

  @override
  State<ApprovedRejectedClg> createState() => _ApprovedRejectedClgState();
}

class _ApprovedRejectedClgState extends State<ApprovedRejectedClg> {

  List<dynamic> acceptedData = [];
  List<dynamic> rejectedData = [];

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

          //Clear every time this both List.. because  if not clear then data Repeated  every time.
          acceptedData.clear();
          rejectedData.clear();

        if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("there is an error for approved rejected college screen"),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data as  List<dynamic>;
                print("show reject data == $data");
                print("show reject data lungth == ${data.length}");
              data.forEach((acceptedForm) {
                if(acceptedForm["status"] == "accepted"){
                  acceptedData.add(acceptedForm);
                }
              });
              if (acceptedData.isEmpty) {
                return   Center(
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
                        "No favorites yet",
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
              print("only show accepted data == $acceptedData");
              print("only show accepted form length = ${acceptedData.length}");

              data.forEach((rejectedForm) {
                if(rejectedForm["status"] == "rejected"){
                  rejectedData.add(rejectedForm);
                }
              });
              if (rejectedData.isEmpty) {
                return   Center(
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
                        "No favorites yet",
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

              print("only show rejected data == $rejectedData");
              print("only show rejected form length = ${rejectedData.length}");

              return  SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      scrollDirection: Axis.vertical,
                      // itemCount: 1,
                      itemCount: acceptedData.length,
                      itemBuilder: (context, index) => Card(
                        color: const Color(0xFF71B173),
                        elevation: 4, // Elevation adds a shadow below the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Rounded corners for the card
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                
                              Text(
                                'Application id : ${acceptedData[index]["student_detail"][0]["_id"]}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: grey88Color,
                                  fontWeight: FontWeight.w700,
                
                                ),
                              ),
                              Text(
                                'College Name : ${acceptedData[index]["college"][0]["collegename"]}',
                                style: TextStyle(color: grey88Color,fontSize: 15),
                              ),
                              Text(
                                'Student Name : ${acceptedData[index]["student_detail"][0]["name"]}',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: grey88Color,
                
                                ),
                              ),
                              Text(
                                'Email : ${acceptedData[index]["studentname"][0]["email"]}',
                                style: const TextStyle(color: grey88Color,fontSize: 15),
                
                              ),
                              Text(
                                'Course Name : ${acceptedData[index]["course"][0]["subjectname"]}',
                                style: const TextStyle(color: grey88Color,fontSize: 15),
                              ),
                
                              Text(
                                'Application Status : ${acceptedData[index]["status"]}',
                                style:
                                const TextStyle(color: grey88Color, fontSize: 15),
                              )
                
                
                
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                    ),
                    SizedBox(height: 10.h,),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      scrollDirection: Axis.vertical,
                      // itemCount: 1,
                      itemCount: rejectedData.length,
                      itemBuilder: (context, index) => Card(
                        color: Color(0xFFEA6E5E),
                        elevation: 4, // Elevation adds a shadow below the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), // Rounded corners for the card
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Application id : ${rejectedData[index]["student_detail"][0]["_id"]}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: grey88Color,
                                  fontWeight: FontWeight.w700,
                
                                ),
                              ),
                              Text(
                                'College Name : ${rejectedData[index]["college"][0]["collegename"]}',
                                style: const TextStyle(color: grey88Color,fontSize: 15),
                              ),
                              Text(
                                'Student Name : ${rejectedData[index]["student_detail"][0]["name"]}',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: grey88Color,
                
                                ),
                              ),
                              Text(
                                'Email : ${rejectedData[index]["studentname"][0]["email"]}',
                                style: const TextStyle(color: grey88Color,fontSize: 15),
                
                              ),
                              Text(
                                'Course Name : ${rejectedData[index]["course"][0]["subjectname"]}',
                                style: const TextStyle(color: grey88Color,fontSize: 15),
                              ),
                
                              Text(
                                'Application Status : ${rejectedData[index]["status"]}',
                                style: const TextStyle(color: grey88Color, fontSize: 15),
                              )
                
                
                
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                    ),
                  ],
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
