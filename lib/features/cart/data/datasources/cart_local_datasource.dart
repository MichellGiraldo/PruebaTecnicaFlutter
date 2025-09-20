import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> saveCartItems(List<CartItemModel> items);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final String? cartJson = sharedPreferences.getString(AppConstants.cartStorageKey);
      if (cartJson != null) {
        final List<dynamic> jsonList = json.decode(cartJson);
        return jsonList.map((json) => CartItemModel.fromJson(json)).toList();
      }
      return <CartItemModel>[];
    } catch (e) {
      throw CacheFailure('Error al obtener items del carrito: $e');
    }
  }

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    try {
      final String cartJson = json.encode(items.map((item) => item.toJson()).toList());
      await sharedPreferences.setString(AppConstants.cartStorageKey, cartJson);
    } catch (e) {
      throw CacheFailure('Error al guardar items del carrito: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await sharedPreferences.remove(AppConstants.cartStorageKey);
    } catch (e) {
      throw CacheFailure('Error al limpiar el carrito: $e');
    }
  }
}
