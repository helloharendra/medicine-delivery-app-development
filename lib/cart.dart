import 'package:flutter/widgets.dart';

import 'data.dart';

/// Cart state shared via InheritedNotifier (no extra packages).
class MedCart extends ChangeNotifier {
  final Map<Medicine, int> items = {};
  bool prescriptionUploaded = false;

  int qty(Medicine m) => items[m] ?? 0;
  int get count => items.values.fold(0, (a, b) => a + b);
  int get total => items.entries.fold(0, (s, e) => s + e.key.price * e.value);
  int get mrpTotal => items.entries.fold(0, (s, e) => s + e.key.mrp * e.value);
  bool get needsRx => items.keys.any((m) => m.rx);

  void add(Medicine m) {
    items[m] = qty(m) + 1;
    notifyListeners();
  }

  void remove(Medicine m) {
    final q = qty(m) - 1;
    q <= 0 ? items.remove(m) : items[m] = q;
    notifyListeners();
  }

  void uploadPrescription() {
    prescriptionUploaded = true;
    notifyListeners();
  }
}

class CartScope extends InheritedNotifier<MedCart> {
  const CartScope({super.key, required MedCart cart, required super.child}) : super(notifier: cart);
  static MedCart of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<CartScope>()!.notifier!;
}
