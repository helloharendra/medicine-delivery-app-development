import 'package:flutter/material.dart';

import '../cart.dart';
import '../core/contact.dart';
import '../data.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.paddingOf(context).top + 12, 20, 24),
          decoration: const BoxDecoration(color: ink, borderRadius: BorderRadius.vertical(bottom: Radius.circular(28))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.location_on_rounded, color: Color(0xFF5EEAD4), size: 20),
              const SizedBox(width: 6),
              const Expanded(child: Text('Deliver to  ·  Andheri West, 400053', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
              IconButton(onPressed: () => Contact.show(context, appName, 'Health Profile & Family Members'), icon: const Icon(Icons.account_circle_outlined, color: Colors.white)),
            ]),
            const SizedBox(height: 8),
            const Text('Medicines delivered\nin 30 minutes', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, height: 1.15)),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              onTap: () => Contact.show(context, appName, 'Medicine Search (by brand or salt)'),
              decoration: InputDecoration(
                hintText: 'Search medicines & health products',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
          ]),
        ),
      ),
      // Prescription upload
      SliverToBoxAdapter(
        child: ListenableBuilder(
          listenable: cart,
          builder: (_, __) => Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF14B8A6), Color(0xFF0F9D8A)]),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [BoxShadow(color: brand.withValues(alpha: .3), blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.receipt_long_rounded, color: Colors.white, size: 30)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(cart.prescriptionUploaded ? 'Prescription uploaded ✓' : 'Order with prescription', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  Text(cart.prescriptionUploaded ? 'Our pharmacist is verifying it' : 'Upload & let our pharmacist do the rest', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ]),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: brand),
                onPressed: cart.prescriptionUploaded ? null : cart.uploadPrescription,
                child: Text(cart.prescriptionUploaded ? 'Done' : 'Upload'),
              ),
            ]),
          ),
        ),
      ),
      const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Shop by category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)))),
      SliverPadding(
        padding: const EdgeInsets.all(20),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12, mainAxisExtent: 96),
          delegate: SliverChildListDelegate(categories
              .map((c) => InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => Contact.show(context, appName, c.$1),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        CircleAvatar(backgroundColor: c.$3.withValues(alpha: .12), child: Icon(c.$2, color: c.$3)),
                        const SizedBox(height: 6),
                        Text(c.$1, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ]),
                    ),
                  ))
              .toList()),
        ),
      ),
      const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 12), child: Text('Top deals for you', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)))),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 240, mainAxisSpacing: 12, crossAxisSpacing: 12, mainAxisExtent: 226),
          delegate: SliverChildBuilderDelegate((_, i) => _MedCard(medicines[i]), childCount: medicines.length),
        ),
      ),
    ]);
  }
}

class _MedCard extends StatelessWidget {
  const _MedCard(this.m);
  final Medicine m;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final q = cart.qty(m);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          Container(height: 86, width: double.infinity, decoration: BoxDecoration(color: m.color.withValues(alpha: .1), borderRadius: BorderRadius.circular(14)), child: Icon(m.icon, size: 44, color: m.color)),
          if (m.rx) Positioned(right: 6, top: 6, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFFE11D48), borderRadius: BorderRadius.circular(6)), child: const Text('Rx', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)))),
        ]),
        const SizedBox(height: 8),
        Text(m.brand.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black38, letterSpacing: 1)),
        Text(m.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, height: 1.2)),
        Text(m.pack, style: const TextStyle(fontSize: 11, color: Colors.black45)),
        const Spacer(),
        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('₹${m.price}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
              Text('${m.off}% off', style: const TextStyle(fontSize: 11, color: brand, fontWeight: FontWeight.w700)),
            ]),
          ),
          q == 0
              ? FilledButton(style: FilledButton.styleFrom(minimumSize: const Size(56, 34), padding: const EdgeInsets.symmetric(horizontal: 12)), onPressed: () => cart.add(m), child: const Text('Add'))
              : Container(
                  decoration: BoxDecoration(color: brand, borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    InkWell(onTap: () => cart.remove(m), child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.remove, color: Colors.white, size: 16))),
                    Text('$q', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    InkWell(onTap: () => cart.add(m), child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.add, color: Colors.white, size: 16))),
                  ]),
                ),
        ]),
      ]),
    );
  }
}
