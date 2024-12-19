import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateInStarWidget extends StatelessWidget {
  const RateInStarWidget({super.key, this.iconSize, required this.reviewStar,});
  final double? iconSize;
  final String reviewStar;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.only(left: 05,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBar.builder(
              initialRating: double.parse(reviewStar),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 13,
              // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context,_)  =>
              const Icon(Icons.star_rate_rounded,
                color: Color.fromRGBO(255, 214, 0, 1),),
              onRatingUpdate: (rating) {
                print(rating);
              },
            tapOnlyMode: true, // Set to true to disable interaction
            ignoreGestures: true,
          )
        ],

      ),
    );
  }
}
