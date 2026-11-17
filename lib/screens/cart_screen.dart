import 'package:flutter/material.dart';

import '../cart.dart';
import '../core/contact.dart';
import '../main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    if (cart.items.isEmpty) {
      return const Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.shopping_cart_outlined, size: 72, color: Colors.black26),
          SizedBox(height: 8),
          Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        ]),
      );
    }
    final blocked = cart.needsRx && !cart.prescriptionUploaded;
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Cart', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        ...cart.items.keys.map((m) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                Container(width: 52, height: 52, decoration: BoxDecoration(color: m.color.withValues(alpha: .1), borderRadius: BorderRadius.circular(12)), child: Icon(m.icon, color: m.color)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [Flexible(child: Text(m.name, style: const TextStyle(fontWeight: FontWeight.w700))), if (m.rx) const Text('  Rx', style: TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.w800, fontSize: 12))]),
                    Text('${m.pack} · ₹${m.price}', style: const TextStyle(color: Colors.black45, fontSize: 12)),
                  ]),
                ),
                IconButton(onPressed: () => cart.remove(m), icon: const Icon(Icons.remove_circle_outline)),
                Text('${cart.qty(m)}', style: const TextStyle(fontWeight: FontWeight.w800)),
                IconButton(onPressed: () => cart.add(m), icon: const Icon(Icons.add_circle, color: brand)),
              ]),
            )),
        if (cart.needsRx)
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: blocked ? const Color(0xFFFFF1F2) : const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              Icon(blocked ? Icons.warning_amber_rounded : Icons.verified_rounded, color: blocked ? const Color(0xFFE11D48) : brand),
              const SizedBox(width: 10),
              Expanded(child: Text(blocked ? 'Your cart has prescription medicines. Please upload a valid prescription.' : 'Prescription attached. Pharmacist verification in progress.', style: const TextStyle(fontSize: 13))),
              if (blocked) TextButton(onPressed: cart.uploadPrescription, child: const Text('Upload')),
            ]),
          ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Column(children: [
            _row('MRP total', '₹${cart.mrpTotal}'),
            _row('Discount', '−₹${cart.mrpTotal - cart.total}', color: brand),
            _row('Delivery', cart.total >= 299 ? 'FREE' : '₹29', color: cart.total >= 299 ? brand : null),
            const Divider(height: 24),
            _row('Amount to pay', '₹${cart.total + (cart.total >= 299 ? 0 : 29)}', bold: true),
          ]),
        ),
        const SizedBox(height: 16),
        FilledButton(
          style: FilledButton.styleFrom(padding: const EdgeInsets.all(18)),
          onPressed: blocked ? null : () => Contact.show(context, appName, 'Checkout, Payments & Pharmacy Assignment'),
          child: const Text('Proceed to checkout', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        ),
      ]),
    );
  }

  Widget _row(String k, String v, {Color? color, bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          Expanded(child: Text(k, style: TextStyle(color: bold ? Colors.black : Colors.black54, fontWeight: bold ? FontWeight.w800 : FontWeight.w500))),
          Text(v, style: TextStyle(color: color ?? Colors.black87, fontWeight: bold ? FontWeight.w900 : FontWeight.w700, fontSize: bold ? 17 : 14)),
        ]),
      );
}
