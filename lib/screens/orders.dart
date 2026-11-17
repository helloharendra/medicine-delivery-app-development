import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../main.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const steps = [
    ('Prescription verified', 'By pharmacist Rina S. · 10:02 AM', true),
    ('Packed at MedRush Andheri', '10:09 AM', true),
    ('Out for delivery', 'Sanjay is 1.2 km away', true),
    ('Delivered', 'Expected by 10:35 AM', false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Orders', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(24)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [
              Text('#MR-20931', style: TextStyle(color: Colors.white70)),
              Spacer(),
              Text('Arriving in 12 min', style: TextStyle(color: Color(0xFF5EEAD4), fontWeight: FontWeight.w800)),
            ]),
            const SizedBox(height: 6),
            const Text('3 items · ₹437 · Paid via UPI', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 18),
            ...List.generate(steps.length, (i) {
              final s = steps[i];
              return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(children: [
                  Icon(s.$3 ? Icons.check_circle_rounded : Icons.radio_button_unchecked, color: s.$3 ? const Color(0xFF5EEAD4) : Colors.white38, size: 22),
                  if (i < steps.length - 1) Container(width: 2, height: 30, color: s.$3 ? const Color(0xFF5EEAD4) : Colors.white24),
                ]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.$1, style: TextStyle(color: s.$3 ? Colors.white : Colors.white54, fontWeight: FontWeight.w700)),
                    Text(s.$2, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ]),
                ),
              ]);
            }),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: OutlinedButton.icon(style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white30)), onPressed: () => Contact.show(context, appName, 'Live Rider Tracking'), icon: const Icon(Icons.map_outlined), label: const Text('Track'))),
              const SizedBox(width: 10),
              Expanded(child: FilledButton.icon(onPressed: () => Contact.show(context, appName, 'Call Delivery Partner'), icon: const Icon(Icons.call), label: const Text('Call'))),
            ]),
          ]),
        ),
        const SizedBox(height: 20),
        const Text('Past orders', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
        const SizedBox(height: 10),
        for (final (id, items, amt, date) in [('#MR-19804', 'Vitamin D3, ORS Electrolyte', 308, '2 Nov'), ('#MR-18772', 'Metformin 500mg ×2', 78, '12 Oct')])
          Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Color(0xFFE6F6F3), child: Icon(Icons.inventory_2_outlined, color: brand)),
              title: Text(items, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('$id · Delivered $date · ₹$amt'),
              trailing: TextButton(onPressed: () => Contact.show(context, appName, 'Reorder & Refill Reminders'), child: const Text('Reorder')),
            ),
          ),
      ]),
    );
  }
}
