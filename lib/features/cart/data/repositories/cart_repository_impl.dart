import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../models/cart_item_model.dart';
import '../../../../core/errors/failures.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final items = await localDataSource.getCartItems();
      return items.cast<CartItem>();
    } catch (e) {
      if (e is CacheFailure) rethrow;
      throw CacheFailure('Error inesperado: $e');
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      final items = await localDataSource.getCartItems();
      final existingItemIndex = items
          .indexWhere((cartItem) => cartItem.product.id == item.product.id);

      if (existingItemIndex != -1) {
        items[existingItemIndex] = CartItemModel(
          product: item.product,
          quantity: items[existingItemIndex].quantity + item.quantity,
        );
      } else {
        items.add(CartItemModel.fromEntity(item));
      }

      await localDataSource.saveCartItems(items);
    } catch (e) {
      if (e is CacheFailure) rethrow;
      throw CacheFailure('Error al agregar al carrito: $e');
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    try {
      final items = await localDataSource.getCartItems();
      items.removeWhere((item) => item.product.id == productId);
      await localDataSource.saveCartItems(items);
    } catch (e) {
      if (e is CacheFailure) rethrow;
      throw CacheFailure('Error al remover del carrito: $e');
    }
  }

  @override
  Future<void> updateCartItem(CartItem item) async {
    try {
      final items = await localDataSource.getCartItems();
      final index = items
          .indexWhere((cartItem) => cartItem.product.id == item.product.id);

      if (index != -1) {
        if (item.quantity <= 0) {
          items.removeAt(index);
        } else {
          items[index] = CartItemModel.fromEntity(item);
        }
        await localDataSource.saveCartItems(items);
      }
    } catch (e) {
      if (e is CacheFailure) rethrow;
      throw CacheFailure('Error al actualizar el carrito: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await localDataSource.clearCart();
    } catch (e) {
      if (e is CacheFailure) rethrow;
      throw CacheFailure('Error al limpiar el carrito: $e');
    }
  }

  @override
  Future<int> getCartItemsCount() async {
    try {
      final List<CartItemModel> items = await localDataSource.getCartItems();
      int count = 0;
      for (final item in items) {
        count += item.quantity;
      }
      return count;
    } catch (e) {
      if (e is CacheFailure) rethrow;
      throw CacheFailure('Error al obtener el conteo del carrito: $e');
    }
  }

  @override
  Future<double> getCartTotal() async {
    try {
      final List<CartItemModel> items = await localDataSource.getCartItems();
      double total = 0.0;
      for (final item in items) {
        total += item.totalPrice;
      }
      return total;
    } catch (e) {
      if (e is CacheFailure) rethrow;
      throw CacheFailure('Error al obtener el total del carrito: $e');
    }
  }
}
