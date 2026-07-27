import 'producto.dart';

class ProductoDto {
  final int     id;
  final String  name;
  final String  price;
  final bool    isActive;
  final String? categoryName;

  const ProductoDto({
    required this.id,
    required this.name,
    required this.price,
    required this.isActive,
    this.categoryName,
  });

  factory ProductoDto.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String? ?? json['name'] as String? ?? 'Curso sin título';
    final priceNum = json['price'];
    final priceStr = priceNum != null ? priceNum.toString() : '0';
    
    String? catName;
    if (json['category'] != null && json['category'] is Map) {
      catName = json['category']['name'] as String?;
    } else {
      catName = json['category_name'] as String?;
    }

    return ProductoDto(
      id:           json['id'] as int? ?? 0,
      name:         title,
      price:        priceStr,
      isActive:     json['is_active'] as bool? ?? true,
      categoryName: catName,
    );
  }

  Producto toDomain() => Producto(
    id:        id,
    nombre:    name,
    precio:    double.tryParse(price) ?? 0,
    activo:    isActive,
    categoria: categoryName,
  );
}
