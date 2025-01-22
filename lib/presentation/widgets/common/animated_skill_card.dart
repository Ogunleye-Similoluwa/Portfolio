import 'package:flutter/material.dart';

class AnimatedSkillCard extends StatefulWidget {
  final String skillName;
  final double proficiency;
  final String iconPath;

  const AnimatedSkillCard({
    required this.skillName,
    required this.proficiency,
    required this.iconPath,
  });

  @override
  State<AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<AnimatedSkillCard> {
  @override
  Widget build(BuildContext context) {
    return Container(); // TODO: Implement animated skill card
  }
} 