import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;

  const AddToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final int productId;

  const RemoveFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateCartItem extends CartEvent {
  final CartItem item;

  const UpdateCartItem(this.item);

  @override
  List<Object> get props => [item];
}

class ClearCart extends CartEvent {}
