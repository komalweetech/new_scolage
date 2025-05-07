import 'package:flutter/material.dart';

class YoutubeImageWidget extends StatelessWidget {
  final List<dynamic>? videoList;
  
  const YoutubeImageWidget({
    super.key,
    this.videoList,
  });

  @override
  Widget build(BuildContext context) {
    // Default images to show when no videos are available
    final List<String> defaultImages = [
      'assets/image/image_1.jpg',
      'assets/image/image_2.jpg',
      'assets/image/image_3.jpg',
      'assets/image/image_4.jpg',
    ];

    // Use video thumbnails if available, otherwise use default images
    final List<String> images = (videoList?.isNotEmpty == true)
        ? videoList!.take(4).map((video) => (video['thumbnail'] as String?) ?? defaultImages[0]).toList()
        : defaultImages;

    return SizedBox(
      width: 170,
      height: 125,
      child: Stack(
        alignment: Alignment.center,
        textDirection: TextDirection.rtl,
        fit: StackFit.loose,
        clipBehavior: Clip.hardEdge,
        children: [
          // Only show images if we have them
          if (images.isNotEmpty)
            for (int i = 0; i < images.length; i++)
              Positioned(
                bottom: i * 6.0 - 8.5,
                left: i * 6.0,
                child: Container(
                  width: 150,
                  height: 115,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: images[i].startsWith('assets/')
                          ? Image.asset(
                              images[i],
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              images[i],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  defaultImages[0],
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
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

