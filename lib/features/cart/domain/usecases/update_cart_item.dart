import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class UpdateCartItem {
  final CartRepository repository;

  UpdateCartItem(this.repository);

  Future<void> call(CartItem item) async {
    await repository.updateCartItem(item);
  }
}
