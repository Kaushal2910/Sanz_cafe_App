import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'pages/user/home_page.dart';
import 'state/cart_provider.dart';
import 'pages/user/menu_page.dart';
import 'pages/user/cart_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const SanzCafeApp(),
    ),
  );
}

class SanzCafeApp extends StatelessWidget {
  const SanzCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanz Café',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomePage(),
      routes: {
        '/menu': (_) => const MenuPage(),
        '/cart': (_) => const CartPage(),
        // add other routes
      },
    );
  }
}
