import '../repositories/cart_repository.dart';

class GetCartCount {
  final CartRepository repository;

  GetCartCount(this.repository);

  Future<int> call() async {
    return await repository.getCartItemsCount();
  }
}
