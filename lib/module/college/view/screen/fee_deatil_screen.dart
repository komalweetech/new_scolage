import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/collegedatalist.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../widget/college_detail_screen_title_and_description_widget.dart';
import '../widget/fees_list_widgets.dart';

class FeeDetailScreen extends StatefulWidget {
  const FeeDetailScreen({super.key,this.eligibility,this.feeTerms,required this.clgId,});
  final String? feeTerms;
  final String? eligibility;
  final String clgId;

  @override
  State<FeeDetailScreen> createState() => _FeeDetailScreenState();
}

class _FeeDetailScreenState extends State<FeeDetailScreen> {
   List<dynamic> subjectList = [];
   List<dynamic> collegeSubjectList = [];
   List<dynamic> selectSubjectList = [];


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    subjectList.add(AllCollegeData.collegeDataList["subject"]);
    print("subject List = $subjectList");
    print("select college ID = ${widget.clgId}");

    //add this list to collegeSubject list.
    collegeSubjectList = subjectList[0];
    print("subject list length = ${collegeSubjectList.length}");

    //filter college Subject list and add other list.
     for(int i = 0; collegeSubjectList.length > i; i++){
       if(widget.clgId == collegeSubjectList[i]["collegeid"])  {
         selectSubjectList.add(collegeSubjectList[i]);
       }
     }
    print("filtered  college subject list = $selectSubjectList");
    print("total length for subject list = ${selectSubjectList.length} ");

   }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          leadingWidth: 80,
          leading: Center(
            child: Container(
              height: 32.h,
              width: 32.h,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  AssetIcons.COLLEGE_DETAIL_SCREEN_BACK_ARROW_ICON,
                ),
              ),
            ),
          ),
          title: const Text("Fee Details",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700),),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        children: [
          SizedBox(height: 50.h),
           ListView.separated(
             shrinkWrap: true,
             itemCount: selectSubjectList.length,
             itemBuilder: (context,index) {
               return  FeesListWidget(
                 title: "${selectSubjectList[index]["subjectname"]}",
                 minFees: "${selectSubjectList[index]["minFees"]}",
                 maxFees: "${selectSubjectList[index]["maxFees"]}",
               );
             },
             separatorBuilder: (context, index) => SizedBox(height: 10.h),
           ),

          SizedBox(height: 30.h),
           CollegeDetailScreenTitleAndDescriptionWidget(
            title: "Eligibility Criteria",
            description: "${widget.eligibility}",
          ),
          SizedBox(height: 30.h),
           CollegeDetailScreenTitleAndDescriptionWidget(
            title: "Fee Terms",
            description: "${widget.feeTerms}",
                // "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ",
          )
        ],
      ),
    );
  }
}
