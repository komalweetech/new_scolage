// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../dashboard/view/widget/simple_common_appbar.dart';
import '../../services/AppliedCollegesApi.dart';

class PanddingColleges extends StatefulWidget {
  const PanddingColleges({super.key});

  @override
  State<PanddingColleges> createState() => _PanddingCollegesState();
}



class _PanddingCollegesState extends State<PanddingColleges> {

  List<dynamic> pendingData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(100 + MediaQuery.of(context).padding.top),
        child: SimpleCommonAppBar(),
      ),
      body: FutureBuilder(
        future: AppliedCollegesApi.getAppliedApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("there is an error for pandding college screen"),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data as  List<dynamic>;


              data.forEach((form) {
                if(form["status"] == "pending"){
                 pendingData.add(form);
                }
              });

              if (pendingData.isEmpty) {
                return Center(
                  child:Image.asset("assets/icons/no_data_image.png",height: 300.sp,),
                  // Text("No pending  colleges found"),
                );
              }
              print("only show pendding data == $pendingData");
              print("only show pending form length = ${pendingData.length}");

              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight - 100,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      scrollDirection: Axis.vertical,
                      // itemCount: 1,
                      itemCount: pendingData.length,
                      itemBuilder: (context, index) => Card(
                        color: Color(0xFFA5D6A7),
                        elevation: 4, // Elevation adds a shadow below the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Rounded corners for the card
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Text(
                                'Application id : ${pendingData[index]["student_detail"][0]["_id"]}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: grey88Color,
                                  fontWeight: FontWeight.w700,

                                ),
                              ),
                              Text(
                                'College Name : ${pendingData[index]["college"][0]["collegename"]}',
                                style: TextStyle(color: grey88Color,fontSize: 15),
                              ),
                              Text(
                                'Student Name : ${pendingData[index]["student_detail"][0]["name"]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: grey88Color,

                                ),
                              ),
                              Text(
                                'Email : ${pendingData[index]["studentname"][0]["email"]}',
                                style: TextStyle(color: grey88Color,fontSize: 15),

                              ),
                              Text(
                                'Course Name : ${pendingData[index]["course"][0]["subjectname"]}',
                                style: TextStyle(color: grey88Color,fontSize: 15),
                              ),

                              Text(
                                'Application Status : ${pendingData[index]["status"]}',
                                style:
                                TextStyle(color: grey88Color, fontSize: 15),
                              )



                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                    ),
                  ),
                ],
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
