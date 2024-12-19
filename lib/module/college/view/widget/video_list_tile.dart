


import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/theme/common_color.dart';

class VideoListTile extends StatefulWidget {
  const VideoListTile({super.key,required this.videoLink});
  final String videoLink;

  @override
  State<VideoListTile> createState() => _VideoListTileState();
}

class _VideoListTileState extends State<VideoListTile> {
  late String videoId;
  late String thumbnailUrl = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.videoLink) ?? " ";
    thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 90.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(51, 51, 51, 1),
            image: thumbnailUrl.isNotEmpty
                ? DecorationImage(
              image: NetworkImage(thumbnailUrl),
              fit: BoxFit.cover,
            )
                : null,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teaching Videos",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color.fromRGBO(58, 60, 60, 1.0),fontFamily: "Poppins",fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 90.w,
                child: const CommonDivider(thickness: 1.5),
              ),
              SizedBox(height: 5.h),
              Text(
               widget.videoLink,
                style: TextStyle(fontSize: 13.sp, color: grey102Color),
              ),
              SizedBox(height: 2.h),
              // Text(
              //   "Qualification | Designation",
              //   style: TextStyle(
              //       fontSize: 13.sp,
              //       color: const Color.fromRGBO(166, 168, 171, 1)),
              // ),
              // SizedBox(height: 5.h),
              // SizedBox(
              //   width: 50.w,
              //   child: const CommonDivider(thickness: .5),
              // ),
              // SizedBox(height: 3.h),
              // Text(
              //   "Experience",
              //   style: TextStyle(fontSize: 13.sp, color: grey102Color),
              // ),
              // SizedBox(height: 2.h),
              // Text(
              //   "Total: 10yrs | Current: 5yrs",
              //   style: TextStyle(
              //       fontSize: 13.sp,
              //       color: const Color.fromRGBO(166, 168, 171, 1)),
              // ),
            ],
          ),
        ),
      ],
    );
  }


}

