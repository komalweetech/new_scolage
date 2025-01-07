import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../college/view/screen/college_detail_screen.dart';
import 'college_card_detail_widget.dart';

class CollegeCard extends StatefulWidget {
  const CollegeCard({super.key, required this.index, this.height, this.width,
    this.clgImage, this.clgName,this.clgId,this.clgAdd,this.clgDetails,this.policy, this.eligibility, this.feeTerms,this.safety,
  this.subjectName,this.staffList,this.socialMedia,this.open,this.close,this.days,
    this.clgType,this.systemType,this.academicType,this.affiliated,this.classType,this.classrooms,this.totalSeats,this.totalFloors,this.totalArea,this.clgCode,
    this.clgImageList,this.videoList,this.webSiteLink,this.location,this.description,this.more_info,this.history, this.collegeStatus
  });
  final int index;
  final double? height;
  final double? width;
  final String? clgImage;
  final List<dynamic>? clgImageList;
  final String? clgName;
  final String? clgId;
  final String? clgAdd;
  final List<dynamic>? socialMedia;
  final List<dynamic>? clgDetails;
  final String? policy;
  final String? eligibility;
  final String? feeTerms;
  final List<dynamic>? staffList;
  final String? safety;
  final List< dynamic>? subjectName;
  final String? open;
  final String? close;
  final String? days;
  final String? description;
  final String? more_info;
  final String? history;
  final List<dynamic>? videoList;
  final String? webSiteLink;

  // College Details
  final String? clgType;
  final String? systemType;
  final String? academicType;
  final String? affiliated;
  final String? classType;
  final String? classrooms;
  final String? totalSeats;
  final String? totalFloors;
  final String? totalArea;
  final String? clgCode;
  final String? location;
  final String? collegeStatus;

  @override
  State<CollegeCard> createState() => _CollegeCardState();
}


class _CollegeCardState extends State<CollegeCard> {
  @override
  Widget build(BuildContext context) {
    print("1111111111111111 = ${widget.clgId}");
    print("1111111111111111 = ${widget.clgName}");
    print("1111111111111111 = ${widget.clgDetails}");
    print("1111111111111111 = ${widget.clgAdd}");
    print("college Image == ${widget.clgImage}");

    print("staff list == ${widget.staffList}");
    // print
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(7.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(7.r),
          onTap: () {
            CommonFunction.kNavigatorPush(context, CollegeDetailScreen(
              clgDetails: widget.clgDetails,
              policy: widget.policy!,
              eligibility: widget.eligibility!,
              feeTerms: widget.feeTerms,
              clgImage: widget.clgImage!,
              clgName: widget.clgName!,
              clgId: widget.clgId!,
              clgAdd: widget.clgAdd,
              safety: widget.safety!,
              courseDetails: widget.subjectName,
              staffList: widget.staffList!,
              socialDetails: widget.socialMedia,
              open: widget.open,
              close: widget.close,
              days: widget.days,
              description : widget.description,
              history: widget.history,
              more_info: widget.more_info,
              clgImageList: widget.clgImageList!,
              videoList: widget.videoList,
              webSiteLink: widget.webSiteLink,
              location: widget.location,

              // all for College Details.......
              clgType: widget.clgType,
              systemType: widget.systemType,
              academicType: widget.academicType,
              affiliated: widget.affiliated,
              classType: widget.classType,
              classrooms: widget.classrooms,
              totalSeats: widget.totalSeats,
              totalFloors: widget.totalFloors,
              totalArea: widget.totalArea,
              clgCode: widget.clgCode,
              collegeStatus: widget.collegeStatus,
            ));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: SizedBox(
                  height: widget.height,
                  width: widget.width,
                  // child: Image.network(widget.clgImage!,fit: BoxFit.cover,errorBuilder: (context,error,stackTrace) {
                  //   return Image.network('https://images.unsplash.com/flagged/photo-1554473675-d0904f3cbf38?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGNvbGxlZ2V8ZW58MHx8MHx8fDA%3D',fit: BoxFit.cover);
                  // },)
                  child: Image.network(widget.clgImage!,fit: BoxFit.cover,),
                  ) ,
              ),
              // Positioned(
              //     right: 10,
              //     top: 10,
              //     child: Container(
              //       padding: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(7.r),
              //       ),
              //       child: Image.asset(
              //         AssetIcons.BOOKMARK_ICON,
              //         height: 11.5.h,
              //       ),
              //     )),
               Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: CollegeCardDetail(clgName: widget.clgName,clgAdd: widget.clgAdd,clgId: widget.clgId!,systemType: widget.systemType,),

              )
            ],
          ),
        ),
      ),
    );
  }

}
