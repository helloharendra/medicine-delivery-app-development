import 'package:flutter/material.dart';

/// Sample catalogue for the UI demo. The full app syncs with pharmacy inventory.
class Medicine {
  const Medicine(this.name, this.pack, this.price, this.mrp, this.icon, this.color, {this.rx = false, this.brand = ''});
  final String name, pack, brand;
  final int price, mrp;
  final IconData icon;
  final Color color;
  final bool rx;
  int get off => ((mrp - price) / mrp * 100).round();
}

const categories = <(String, IconData, Color)>[
  ('Medicines', Icons.medication_rounded, Color(0xFF0F9D8A)),
  ('Diabetes', Icons.bloodtype_rounded, Color(0xFFE11D48)),
  ('Vitamins', Icons.wb_sunny_rounded, Color(0xFFF59E0B)),
  ('Baby care', Icons.child_friendly_rounded, Color(0xFF0EA5E9)),
  ('Devices', Icons.monitor_heart_rounded, Color(0xFF6366F1)),
  ('Ayurveda', Icons.spa_rounded, Color(0xFF16A34A)),
  ('Skin care', Icons.face_rounded, Color(0xFFDB2777)),
  ('Lab tests', Icons.biotech_rounded, Color(0xFF7C3AED)),
];

const medicines = <Medicine>[
  Medicine('Paracetamol 650mg', 'Strip of 15 tablets', 30, 34, Icons.medication_rounded, Color(0xFF0F9D8A), brand: 'Dolo'),
  Medicine('Vitamin D3 60K', 'Strip of 4 capsules', 109, 135, Icons.wb_sunny_rounded, Color(0xFFF59E0B), brand: 'Uprise'),
  Medicine('Azithromycin 500mg', 'Strip of 3 tablets', 98, 119, Icons.medication_liquid_rounded, Color(0xFF6366F1), rx: true, brand: 'Azee'),
  Medicine('Metformin 500mg', 'Strip of 20 tablets', 39, 48, Icons.bloodtype_rounded, Color(0xFFE11D48), rx: true, brand: 'Glycomet'),
  Medicine('Digital BP Monitor', '1 unit', 1699, 2499, Icons.monitor_heart_rounded, Color(0xFF6366F1), brand: 'Omron'),
  Medicine('Multivitamin Gummies', 'Bottle of 30', 449, 599, Icons.emoji_food_beverage_rounded, Color(0xFFDB2777), brand: 'HealthKart'),
  Medicine('ORS Electrolyte', 'Pack of 10 sachets', 199, 220, Icons.water_drop_rounded, Color(0xFF0EA5E9), brand: 'Electral'),
  Medicine('Ashwagandha Tablets', 'Bottle of 60', 249, 320, Icons.spa_rounded, Color(0xFF16A34A), brand: 'Himalaya'),
];
