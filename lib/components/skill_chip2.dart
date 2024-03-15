import "package:flutter/material.dart";

class SkillChip2 extends StatelessWidget {
  final String skillName;
  const SkillChip2({super.key, required this.skillName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(219, 223, 247, 1),
      ),
      child: Text(skillName),
    );
  }
}
