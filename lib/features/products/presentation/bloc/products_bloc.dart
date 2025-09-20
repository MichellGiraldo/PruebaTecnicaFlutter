import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;

  ProductsBloc({required this.getProducts}) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError('Error al cargar productos: $e'));
    }
  }

  Future<void> _onRefreshProducts(RefreshProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError('Error al actualizar productos: $e'));
    }
  }
}
