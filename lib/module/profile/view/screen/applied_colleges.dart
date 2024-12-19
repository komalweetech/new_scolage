
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
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
            try{
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("there is an error for applied college screen"),
                  );
                } else if (snapshot.hasData) {
                  var data = snapshot.data as  List<dynamic>;

                  if(data.isEmpty){
                    const Center(child: Text("Student not Applied any Colleges"),);

                  }
                  return ListView(
                    children: [
                      SizedBox(
                        height:  MediaQuery.of(context).size.height - kToolbarHeight - 100,
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          scrollDirection: Axis.vertical,
                          // itemCount: 1,
                          itemCount: data.length,
                          itemBuilder: (context, index) => Card(color: kSecondPrimaryColor,
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
                                    'Application id : ${data[index]["student_detail"][0]["_id"]}',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: grey88Color,
                                      fontWeight: FontWeight.w700,

                                    ),
                                  ),
                                  Text(
                                    'College Name : ${data[index]["college"][0]["collegename"]}',
                                    style: const TextStyle(color: grey88Color,fontSize: 15),
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
                                    style: const TextStyle(color: grey88Color,fontSize: 15),

                                  ),
                                  Text(
                                    'Course Name : ${data[index]["course"][0]["subjectname"]}',
                                    style: const TextStyle(color: grey88Color,fontSize: 15),
                                  ),
                                  // Text(
                                  //   appliedClgData[index]["studentname"][index]["phone"].toInt,
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  Text(
                                    'Application Status : ${data[index]["status"]}',
                                    style: const TextStyle(color: grey88Color,fontSize: 15),


                                  ),

                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(height: 10.h),
                        ),
                      ),
                    ],
                  );
                }
              }
            }catch(e) {
              SvgPicture.asset(AssetIcons.NoAnyData);
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
    );
  }
}
