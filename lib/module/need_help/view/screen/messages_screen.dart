import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../controller/help_controller.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final helpController = Get.find<HelpController>();

    return Scaffold(
      appBar: CommonSubScreenAppBar(
        title: "Your Messages",
      ),
      body: Obx(() => helpController.messages.isEmpty
          ? Center(
              child: Text(
                "No messages yet",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "Poppins",
                  color: Colors.grey[600],
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: helpController.messages.length,
              itemBuilder: (context, index) {
                final message = helpController.messages[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Sent on: ${_formatDate(message.timestamp)}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                              fontFamily: "Poppins",
                            ),
                          ),
                          Text(
                            "Name: ${message.studentId}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                              fontFamily: "Poppins",
                            ),
                          ),
                          Text(
                            "ID: ${message.studentId}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
} 