import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary brand colors
  static Color primaryColor = const Color(0xff3A86FF);    // Vibrant blue - main accent
  static Color secondaryColor = const Color(0xff8338EC);  // Purple - secondary accent
  
  // Background colors
  static Color scaffoldColor = const Color(0xff0A1929);   // Deep blue-black background
  static Color appBarColor = const Color(0xff0F2744);     // Slightly lighter blue for app bar
  static Color primaryLight = const Color(0xff1A3A5A);    // Card/container background
  
  // Text and content colors
  static Color white = const Color(0xffFFFFFF);           // Pure white for main text
  static Color lightColor = const Color(0xffE5E9F0);      // Soft white for secondary text
  static Color lowPriority = const Color(0xff8F9BB3);     // Muted text color
  
  // Additional accent colors
  static Color accentSuccess = const Color(0xff2EC4B6);   // Teal - for success states
  static Color accentWarning = const Color(0xffFF9F1C);   // Orange - for highlights
  static Color darkColor = const Color(0xff051118);       // Darker shade for contrast
}
