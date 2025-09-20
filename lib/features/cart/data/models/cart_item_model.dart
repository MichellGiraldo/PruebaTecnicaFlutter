import '../../domain/entities/cart_item.dart';
import '../../../products/data/models/product_model.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.product,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': (product as ProductModel).toJson(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromEntity(CartItem entity) {
    return CartItemModel(
      product: entity.product,
      quantity: entity.quantity,
    );
  }
}
