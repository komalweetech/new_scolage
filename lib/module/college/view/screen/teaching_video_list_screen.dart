import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_scolage/module/home/model/college_data.dart';
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
  late YoutubePlayerController _controller;
  List<String> videoUrls = [];
  int _currentVideoIndex = 0;


  @override
  void initState() {
    super.initState();
    _initializeVideoData();
    print("video screen == ${widget.clgId}");
    print("video screen == ${widget.videoList}");

  }
  void _initializeVideoData() {

    // Extract all video URLs
    if (widget.videoList.isNotEmpty) {
      videoUrls = widget.videoList
          .where((item) => item is Map<String, dynamic> && item.containsKey('videoUrls'))
          .expand<String>((item) => (item['videoUrls'] as List).map((url) => url.toString()))
          .toList();
    }

    // Initialize controller with first video if available
    if (videoUrls.isNotEmpty) {
      final firstVideoId = YoutubePlayer.convertUrlToId(videoUrls.first) ?? '';
      _controller = YoutubePlayerController(
        initialVideoId: firstVideoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      // Handle case where no videos exist
      _controller = YoutubePlayerController(
        initialVideoId: '',
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  void _playVideo(int index) {
    if (index >= 0 && index < videoUrls.length) {
      final videoId = YoutubePlayer.convertUrlToId(videoUrls[index]) ?? '';
      _controller.load(videoId);
      _controller.play();
      setState(() {
        _currentVideoIndex = index;
      });
    }
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
                onPressed: () => Navigator.pop(context),
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
        children: [
          // **Video Player**
          Container(
            height: 220.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: YoutubePlayer(controller: _controller),
          ),
          SizedBox(height: 10.h),

          // **Video Title & Description**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Video ${_currentVideoIndex + 1}",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 5.h),
                Text(
                  "This is a demo video for teaching purposes. Watch and learn!",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // **Video List**
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                final videoId = YoutubePlayer.convertUrlToId(videoUrls[index]) ?? '';

                return GestureDetector(
                  onTap: () => _playVideo(index),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: _currentVideoIndex == index ? Colors.grey[850] : Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        // **Video Thumbnail**
                        Container(
                          height: 70.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              image: NetworkImage("https://img.youtube.com/vi/$videoId/0.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),

                        // **Video Title**
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Video ${index + 1}",
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Click to play this video.",
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),

                        // **Play Button Icon**
                        Icon(
                          Icons.play_circle_fill,
                          color: _currentVideoIndex == index ? Colors.redAccent : Colors.white,
                          size: 30.w,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}

