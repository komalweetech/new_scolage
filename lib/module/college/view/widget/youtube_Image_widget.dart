import 'package:flutter/material.dart';

import '../../../../utils/constant/asset_icons.dart';

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
      height: 140,
      child: Stack(
          alignment: Alignment.center,
          textDirection: TextDirection.rtl,
          fit: StackFit.loose,
          clipBehavior: Clip.hardEdge,
        children: [
          for (int i = 0; i < images.length; i++)
            Positioned(
              bottom: i * 8.0,
              left: i * 8.0,
              child: Container(
                width: 200,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(images[i]),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(-4, 4),
                    ),
                  ],
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

void _showOverlay(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100,
      left: 50,
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.blueAccent,
          width: 200,
          height: 100,
          child: Center(
            child: Text(
              'Hello, Overlay!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry into the Overlay
  overlay?.insert(overlayEntry);

  // Remove the overlay after 3 seconds
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
