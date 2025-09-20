import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/add_to_cart.dart' as add_to_cart;
import '../../domain/usecases/remove_from_cart.dart' as remove_from_cart;
import '../../domain/usecases/update_cart_item.dart' as update_cart_item;
import '../../domain/usecases/get_cart_count.dart';
import '../../domain/usecases/get_cart_total.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItems getCartItems;
  final add_to_cart.AddToCart addToCart;
  final remove_from_cart.RemoveFromCart removeFromCart;
  final update_cart_item.UpdateCartItem updateCartItem;
  final GetCartCount getCartCount;
  final GetCartTotal getCartTotal;

  CartBloc({
    required this.getCartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartItem,
    required this.getCartCount,
    required this.getCartTotal,
  }) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await getCartItems();
      final itemCount = await getCartCount();
      final total = await getCartTotal();
      emit(CartLoaded(items: items, itemCount: itemCount, total: total));
    } catch (e) {
      emit(CartError('Error al cargar el carrito: $e'));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await addToCart(event.item);
      add(LoadCart());
    } catch (e) {
      emit(CartError('Error al agregar al carrito: $e'));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      await removeFromCart(event.productId);
      add(LoadCart());
    } catch (e) {
      emit(CartError('Error al remover del carrito: $e'));
    }
  }

  Future<void> _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) async {
    try {
      await updateCartItem(event.item);
      add(LoadCart());
    } catch (e) {
      emit(CartError('Error al actualizar el carrito: $e'));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      // Necesitamos agregar un método clearCart al repositorio
      final items = await getCartItems();
      for (final item in items) {
        await removeFromCart(item.product.id);
      }
      add(LoadCart());
    } catch (e) {
      emit(CartError('Error al limpiar el carrito: $e'));
    }
  }
}
