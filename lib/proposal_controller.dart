import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // HTTP package import kar

class ProposalController extends GetxController {
  var noBtnX = 0.0.obs;
  var noBtnY = 0.0.obs;
  var isLoading = false.obs; // Loading dikhane ke liye

  final Random _random = Random();

  // Yaha apni EmailJS ki IDs daal dena
  final String serviceId = "service_nmxcnwi"; // Apni Service ID yaha daal
  final String templateId = "template_8yjyoqn"; // Apni Template ID yaha daal
  final String userId = "6yI_9dHYhEWaeXYBF"; // Apni Public Key yaha daal

  void moveNoButton(Size size) {
    double maxWidth = size.width - 90;
    double maxHeight = 100;
    noBtnX.value = _random.nextDouble() * maxWidth;
    noBtnY.value = _random.nextDouble() * maxHeight;
  }

  Future<bool> sendEmail(String name, String message) async {
    isLoading.value = true;
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'name': '$name\n$message',
          }
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        return true; // Email chala gaya
      } else {
        print("Error: ${response.body}");
        return false; // Kuch gadbad hui
      }
    } catch (e) {
      isLoading.value = false;
      print("Error sending email: $e");
      return false;
    }
  }
}