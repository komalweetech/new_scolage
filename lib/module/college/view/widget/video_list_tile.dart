import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoListTile extends StatelessWidget {
  final String videoLink;
  final bool isSelected;

  const VideoListTile({
    super.key,
    required this.videoLink,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[200] : null,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(Icons.play_circle_fill, color: Colors.red),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Video ${videoLink.substring(videoLink.length - 5)}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}