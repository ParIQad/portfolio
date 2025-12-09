import 'package:flutter/material.dart';

// 1. Hard Skill Bar
class HardSkillItem extends StatelessWidget {
  final String label;
  final double percentage;

  const HardSkillItem({super.key, required this.label, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 4),
          Container(
            height: 15,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(2),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * percentage,
                    color: const Color(0xFF90CAF9),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Soft Skill Tag
class SoftSkillItem extends StatelessWidget {
  final String label;

  const SoftSkillItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, 2),
            blurRadius: 0,
          )
        ],
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}

// 3. Language Row
class LanguageItem extends StatelessWidget {
  final String language;
  final String level;
  final int stars;

  const LanguageItem({
    super.key, 
    required this.language, 
    required this.level, 
    required this.stars
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
              Text(level, style: const TextStyle(fontSize: 12, color: Colors.grey,)),
            ],
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < stars ? Icons.star : Icons.star_border,
                color: Colors.black,
                size: 18,
              );
            }),
          ),
        ],
      ),
    );
  }
}