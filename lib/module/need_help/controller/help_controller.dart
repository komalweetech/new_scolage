import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/help_message_model.dart';
import '../../../utils/StudentDetails.dart';

class HelpController extends GetxController {
  final RxList<HelpMessage> messages = <HelpMessage>[].obs;
  final TextEditingController messageController = TextEditingController();
  static const String _storageKey = 'help_messages';

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  Future<void> loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? messagesJson = prefs.getString(_storageKey);
      
      if (messagesJson != null) {
        final List<dynamic> decodedMessages = json.decode(messagesJson);
        messages.value = decodedMessages
            .map((msg) => HelpMessage.fromJson(msg))
            .where((msg) => msg.studentId == StudentDetails.studentId)
            .toList();
      }
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  Future<void> saveMessage() async {
    if (messageController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final newMessage = HelpMessage(
        message: messageController.text.trim(),
        studentId: StudentDetails.studentId,
        timestamp: DateTime.now(),
      );

      messages.add(newMessage);
      
      // Clear the text field
      messageController.clear();

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> messagesJson = messages.map((msg) => msg.toJson()).toList();
      await prefs.setString(_storageKey, json.encode(messagesJson));

      // Show success message
      Get.snackbar(
        'Success',
        'Message sent successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error saving message: $e');
      Get.snackbar(
        'Error',
        'Failed to send message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void clearMessages() {
    messages.clear();
  }
} 