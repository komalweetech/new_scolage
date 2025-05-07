import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../college/view/screen/college_detail_screen.dart';
import 'college_card_detail_widget.dart';

class CollegeCard extends StatefulWidget {
  const CollegeCard(
      {super.key,
      required this.index,
      this.height,
      this.width,
      this.clgImage,
      this.clgName,
      this.clgId,
      this.clgAdd,
      this.clgDetails,
      this.policy,
      this.eligibility,
      this.feeTerms,
      this.safety,
      this.subjectName,
      this.staffList,
      this.socialMedia,
      this.open,
      this.close,
      this.days,
      this.clgType,
      this.systemType,
      this.academicType,
      this.affiliated,
      this.classType,
      this.classrooms,
      this.totalSeats,
      this.totalFloors,
      this.totalArea,
      this.clgCode,
      this.clgImageList,
      this.videoList,
      this.webSiteLink,
      this.location,
      this.description,
      this.more_info,
      this.history,
      this.collegeStatus,
      this.useDefaultImage = false});

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
  final List<dynamic>? subjectName;
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
  final bool useDefaultImage;

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
            CommonFunction.kNavigatorPush(
                context,
                CollegeDetailScreen(
                  clgDetails: widget.clgDetails ?? [],
                  policy: widget.policy ?? "N/A",
                  eligibility: widget.eligibility ?? "N/A",
                  feeTerms: widget.feeTerms ?? "N/A",
                  clgImage: widget.clgImage ?? "",
                  clgName: widget.clgName ?? "College",
                  clgId: widget.clgId ?? "",
                  clgAdd: widget.clgAdd ?? "N/A",
                  safety: widget.safety ?? "N/A",
                  courseDetails: widget.subjectName ?? [],
                  staffList: widget.staffList ?? [],
                  socialDetails: widget.socialMedia ?? [],
                  open: widget.open ?? "N/A",
                  close: widget.close ?? "N/A",
                  days: widget.days ?? "N/A",
                  description: widget.description ?? "N/A",
                  history: widget.history ?? "N/A",
                  more_info: widget.more_info ?? "N/A",
                  clgImageList: widget.clgImageList ?? [],
                  videoList: widget.videoList ?? [],
                  webSiteLink: widget.webSiteLink ?? "N/A",
                  location: widget.location ?? "N/A",

                  // all for College Details.......
                  clgType: widget.clgType ?? "N/A",
                  systemType: widget.systemType ?? "N/A",
                  academicType: widget.academicType ?? "N/A",
                  affiliated: widget.affiliated ?? "N/A",
                  classType: widget.classType ?? "N/A",
                  classrooms: widget.classrooms ?? "N/A",
                  totalSeats: widget.totalSeats ?? "N/A",
                  totalFloors: widget.totalFloors ?? "N/A",
                  totalArea: widget.totalArea ?? "N/A",
                  clgCode: widget.clgCode ?? "N/A",
                  collegeStatus: widget.collegeStatus ?? "N/A",
                  useDefaultImage: widget.useDefaultImage,
                ));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: _buildImage(widget.clgImage!, widget.useDefaultImage),
                ),
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
                child: CollegeCardDetail(
                  clgName: widget.clgName,
                  clgAdd: widget.clgAdd,
                  clgId: widget.clgId!,
                  systemType: widget.systemType,
                  collegeStatus: widget.collegeStatus,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl, bool useDefaultImage) {
    if (useDefaultImage) {
      return Image.asset(
        'assets/image/clg_image.jpg',
        fit: BoxFit.cover,
      );
    } else if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/image/clg_image.jpg',
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        'assets/image/clg_image.jpg',
        fit: BoxFit.cover,
      );
    }
  }
}
