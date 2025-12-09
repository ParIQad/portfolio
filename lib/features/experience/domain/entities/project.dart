import 'package:flutter/material.dart';

class Project {
  final String title;       // ชื่อโปรเจกต์
  final String category;    // หมวดหมู่
  final String description; // รายละเอียด
  final Color color;        // สีธีมของโปรเจกต์
  final IconData icon;      // ไอคอน

  Project({
    required this.title,
    required this.category,
    required this.description,
    required this.color,
    required this.icon,
  });
}