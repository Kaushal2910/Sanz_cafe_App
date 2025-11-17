import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../theme/app_theme.dart';
import '../../models/menu_item_model.dart';
import '../../state/cart_provider.dart';
import '../../utils/categories.dart';
import '../../components/category_tile.dart';

class MenuPage extends StatefulWidget {
  final String initialCategory;
  const MenuPage({super.key, this.initialCategory = "All"});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItemModel> items = [];
  String selectedCategory = "All";
  bool loading = true;
  String backendBase = "http://10.0.2.2:5000"; // emulator default for localhost

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    fetchItems();
  }

  Future<void> fetchItems() async {
    setState(() => loading = true);
    try {
      final res = await http.get(Uri.parse('$backendBase/api/items'));
      if (res.statusCode == 200) {
        final List decoded = json.decode(res.body);
        items = decoded.map((m) {
          return MenuItemModel(
            id: m['_id'] ?? m['id'] ?? UniqueKey().toString(),
            name: m['name'] ?? '',
            description: m['description'] ?? '',
            category: m['category'] ?? 'Uncategorized',
            imagePath: m['image'] ?? 'assets/images/pizza/p1.png',
            price: (m['price'] is int) ? m['price'] : (int.tryParse('${m['price']}') ?? 0),
          );
        }).toList();
      } else {
        // fallback or empty
        items = [];
      }
    } catch (e) {
      // on error fallback to sample local items (safe)
      items = _sampleLocalItems();
    } finally {
      setState(() => loading = false);
    }
  }

  List<MenuItemModel> _sampleLocalItems() {
    return [
      MenuItemModel(id: 'p1', name: 'Classic Pizza', description: 'Cheesy & tasty', category: 'Pizza', imagePath: 'assets/images/pizza/p1.png', price: 250),
      MenuItemModel(id: 'b1', name: 'Club Burger', description: 'Juicy burger', category: 'Burgers', imagePath: 'assets/images/burgers/b1.png', price: 180),
      MenuItemModel(id: 's1', name: 'Veg Sandwich', description: 'Fresh & crisp', category: 'Sandwich', imagePath: 'assets/images/sandwich/s1.png', price: 120),
      // add a few more as needed
    ];
  }

  List<MenuItemModel> get filtered {
    if (selectedCategory == 'All') return items;
    return items.where((i) => i.category.toLowerCase() == selectedCategory.toLowerCase()).toList();
  }

  Widget _buildCard(MenuItemModel item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.gold.withOpacity(0.9)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image (asset or network)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _imageWidget(item.imagePath),
          ),
          const SizedBox(height: 8),
          Text(item.name, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(item.description, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${item.price}/-", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addItem(item);
                  final snack = SnackBar(content: Text("${item.name} added to cart"), backgroundColor: Colors.green[700]);
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                },
                child: const Text("Add"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageWidget(String path) {
    if (path.startsWith('http')) {
      return Image.network(path, height: 110, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) {
        return Image.asset('assets/images/pizza/p1.png', height: 110, width: double.infinity, fit: BoxFit.cover);
      });
    } else {
      // support jpg/jpeg/png
      return Image.asset(path, height: 110, width: double.infinity, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Sanz Café", style: TextStyle(color: AppTheme.gold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Hero gradient section
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B0B0B), Color(0xFFF9C80E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Welcome to Sanz Café", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text("Fresh • Fast • Delicious", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Categories horizontal
          SizedBox(
            height: 52,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, i) {
                final cat = categories[i];
                return CategoryTile(
                  title: cat,
                  selected: cat == selectedCategory,
                  onTap: () {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Grid of items
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFF9C80E)))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.66,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return _buildCard(item);
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        backgroundColor: AppTheme.gold,
        icon: const Icon(Icons.shopping_cart, color: Colors.black),
        label: Text("${cart.totalItems}"),
      ),
    );
  }
}
