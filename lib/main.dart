// MedRush – Medicine delivery app UI demo by Naya Prayog Technologies (https://nayaprayog.com)
// Run: flutter pub get && flutter run   (Android, iOS or Chrome)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart.dart';
import 'screens/cart_screen.dart';
import 'screens/home.dart';
import 'screens/orders.dart';

const appName = 'MedRush';
const brand = Color(0xFF0F9D8A);
const ink = Color(0xFF0B2B3C);

/// Created once so state survives root rebuilds (resize, rotation, theme changes).
final _cart = MedCart();

void main() => runApp(const MedRushApp());

class MedRushApp extends StatelessWidget {
  const MedRushApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: brand, primary: brand, tertiary: const Color(0xFF6366F1)));
    return CartScope(
      cart: _cart,
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: base.copyWith(scaffoldBackgroundColor: const Color(0xFFF3F7F8), textTheme: GoogleFonts.interTextTheme(base.textTheme)),
        home: const Shell(),
      ),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    return Scaffold(
      body: IndexedStack(index: i, children: const [HomeScreen(), CartScreen(), OrdersScreen()]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        backgroundColor: Colors.white,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded, color: brand), label: 'Home'),
          NavigationDestination(icon: Badge(isLabelVisible: cart.count > 0, label: Text('${cart.count}'), child: const Icon(Icons.shopping_cart_outlined)), selectedIcon: const Icon(Icons.shopping_cart, color: brand), label: 'Cart'),
          const NavigationDestination(icon: Icon(Icons.local_shipping_outlined), selectedIcon: Icon(Icons.local_shipping, color: brand), label: 'Orders'),
        ],
      ),
    );
  }
}
