import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(int productId);
  Future<void> updateCartItem(CartItem item);
  Future<void> clearCart();
  Future<int> getCartItemsCount();
  Future<double> getCartTotal();
}
