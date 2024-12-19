import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../../../utils/theme/common_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widget/video_list_tile.dart';

class TeachingVideoListScreen extends StatefulWidget {
  const TeachingVideoListScreen({super.key,required this.clgId,required this.videoList});
  final String clgId;
  final List<dynamic> videoList;

  @override
  State<TeachingVideoListScreen> createState() =>
      _TeachingVideoListScreenState();
}

class _TeachingVideoListScreenState extends State<TeachingVideoListScreen> {

  final List<dynamic> subVideoList = [];

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    fetchCollegeImages();

    print("clg all videos = = = ${widget.videoList}");
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(subVideoList.first) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }
  void fetchCollegeImages() {
    List<dynamic> subList = widget.videoList;


    print("show video List ==== $subList}");

    for (var i = 0; i < subList.length; i++) {
      if (subList[i]["collegeid"] == widget.clgId) {
        subVideoList.add(subList[i]["videoUrl0"]);
        subVideoList.add(subList[i]["videoUrl1"]);
        subVideoList.add(subList[i]["videoUrl2"]);
        subVideoList.add(subList[i]["videoUrl3"]);
        subVideoList.add(subList[i]["videoUrl4"]);

        print("show only video list == $subVideoList");
        print("show clg id = ${widget.clgId}");
        print("show clg id = ${subList[i]["collegeid"]}");
      }
    }
  }
 void _playVideo(String videoLink) {
   final String videoId = YoutubePlayer.convertUrlToId(videoLink) ?? '';
   _controller.load(videoId);
   _controller.play();
 }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          title: const Text("Demo Videos",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700),),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Center(
                    child: SizedBox(
                      height: 180.h,
                      width: kScreenWidth(context) - 40.w,
                      child:YoutubePlayer(
                        controller: _controller,
                      )
                    ),
                  ),
                ),

          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              itemCount: subVideoList.length,
              itemBuilder: (context, index)  => GestureDetector(
                onTap: (){
                    _playVideo(subVideoList[index]);
                },
                child:  VideoListTile(videoLink: subVideoList[index]),
              ),
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const CommonDivider(
                  thickness: .8,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

