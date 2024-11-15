import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixappassignment/Constants/images.dart';

class Utils {
 static snackbar(String title, String message) {
    Get.rawSnackbar(
      backgroundColor:
          Colors.transparent, 
      snackStyle:
          SnackStyle.FLOATING, 
      messageText: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: Colors.yellowAccent.withOpacity(0.2),
              spreadRadius: 1, 
              blurRadius: 6, 
              offset: const Offset(0, 4), 
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Logo on the left
              Container(
                height: 40.0, // Logo height
                width: 40.0, // Logo width
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(Images.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10), 
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Message
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      snackPosition: SnackPosition.TOP, 
    );
  }
}