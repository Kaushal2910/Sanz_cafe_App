// lib/models/menu_item_model.dart

class MenuItemModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imagePath;
  final int price;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.price,
  });
}
