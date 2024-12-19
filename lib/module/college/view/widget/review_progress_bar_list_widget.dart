import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewProgressBarListWidget extends StatelessWidget {
  const ReviewProgressBarListWidget({super.key,required this.averageReview});
  final int averageReview;

  @override
  Widget build(BuildContext context) {
    double normalize(int value, double max, double min) {
      return (value - min) / (max - min);}

    return Column(
      children: [
         ReviewProgressBarWidget(
          color: Colors.green,
          title: "Excellent",
          value: normalize(averageReview, 5.0, 0.0),
        ),
        SizedBox(height: 4.h),
         ReviewProgressBarWidget(
          color: Color.fromRGBO(165, 214, 49, 1),
          title: "Good",
          value: normalize(averageReview, 5.0, 0.0),
        ),
        SizedBox(height: 4.h),
         ReviewProgressBarWidget(
          color: Colors.yellow,
          title: "Average",
          value: normalize(averageReview, 5.0, 0.0),
        ),
        SizedBox(height: 4.h),
         ReviewProgressBarWidget(
          color: Colors.orange,
          title: "Below Average",
          value: normalize(averageReview, 5.0, 0.0),
        ),
        SizedBox(height: 4.h),
         ReviewProgressBarWidget(
          color: Colors.red,
          title: "Poor",
          value: normalize(averageReview, 0.5, 0.0),
        ),
      ],
    );
  }
}

class ReviewProgressBarWidget extends StatelessWidget {
  const ReviewProgressBarWidget(
      {super.key, required this.title, required this.value, required this.color,});
  final String title;
  final double value;
  final Color color;

  double normalize(double value, double max, double min) {
    return (value - min) / (max - min);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 28,
          child: Text(
            title,
            style: TextStyle(fontSize: 12.sp,fontFamily: "Poppins",fontWeight:FontWeight.w400,color: Colors.black),
          ),
        ),
        Expanded(
          flex: 72,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6.h,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            backgroundColor: const Color.fromRGBO(231, 231, 231, .7),
          ),
        ),
      ],
    );
  }
}
