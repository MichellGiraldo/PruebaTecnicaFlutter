import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _decreaseQuantity(context),
                        icon: const Icon(Icons.remove_circle_outline),
                        iconSize: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _increaseQuantity(context),
                        icon: const Icon(Icons.add_circle_outline),
                        iconSize: 20,
                      ),
                      const Spacer(),
                      Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _removeItem(context),
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  void _increaseQuantity(BuildContext context) {
    final updatedItem = item.copyWith(quantity: item.quantity + 1);
    context.read<CartBloc>().add(UpdateCartItem(updatedItem));
  }

  void _decreaseQuantity(BuildContext context) {
    if (item.quantity > 1) {
      final updatedItem = item.copyWith(quantity: item.quantity - 1);
      context.read<CartBloc>().add(UpdateCartItem(updatedItem));
    } else {
      _removeItem(context);
    }
  }

  void _removeItem(BuildContext context) {
    context.read<CartBloc>().add(RemoveFromCart(item.product.id));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.product.title} removido del carrito'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
