import 'package:flutter/material.dart';

class YoutubeImageWidget extends StatelessWidget {
  const YoutubeImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/image/image_1.jpg',
      'assets/image/image_2.jpg',
      'assets/image/image_3.jpg',
      'assets/image/image_4.jpg',
    ];
    return SizedBox(
      width: 170,
      height: 125,
      child: Stack(
          alignment: Alignment.center,
          textDirection: TextDirection.rtl,
          fit: StackFit.loose,
          clipBehavior: Clip.hardEdge,
        children: [
          for (int i = 0; i < images.length; i++)
            Positioned(
              bottom: i * 6.0 - 8.5,
              left: i * 6.0 ,
              child: Container(
                width: 150,
                height: 115,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(images[i],),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          Center(
            child: Icon(
              Icons.play_circle_fill,
              size: 48,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

