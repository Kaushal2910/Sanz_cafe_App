import 'package:flutter/foundation.dart';
import '../models/menu_item_model.dart';

class CartItem {
  final MenuItemModel item;
  int qty;
  CartItem({required this.item, this.qty = 1});
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get totalItems => _items.values.fold(0, (s, it) => s + it.qty);

  double get totalPrice => _items.values.fold(0, (s, it) => s + it.qty * it.item.price);

  void addItem(MenuItemModel item) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.qty += 1;
    } else {
      _items[item.id] = CartItem(item: item, qty: 1);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    if (!_items.containsKey(id)) return;
    _items[id]!.qty -= 1;
    if (_items[id]!.qty <= 0) _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
