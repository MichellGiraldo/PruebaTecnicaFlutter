import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../widgets/product_card.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        // Cargar productos automáticamente cuando se inicializa
        if (state is ProductsInitial) {
          context.read<ProductsBloc>().add(LoadProducts());
        }
      },
      builder: (context, state) {
        if (state is ProductsInitial) {
          context.read<ProductsBloc>().add(LoadProducts());
          return const LoadingWidget(message: 'Cargando productos...');
        } else if (state is ProductsLoading) {
          return const LoadingWidget(message: 'Cargando productos...');
        } else if (state is ProductsError) {
          return CustomErrorWidget(
            message: state.message,
            onRetry: () {
              context.read<ProductsBloc>().add(RefreshProducts());
            },
          );
        } else if (state is ProductsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProductsBloc>().add(RefreshProducts());
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(context),
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: ProductCard(product: state.products[index]),
                        );
                      },
                      childCount: state.products.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      if (width > 1200) {
        return 6; // Desktop landscape
      } else if (width > 800) {
        return 4; // Tablet landscape
      } else {
        return 3; // Mobile landscape
      }
    } else {
      if (width > 1200) {
        return 4; // Desktop portrait
      } else if (width > 800) {
        return 3; // Tablet portrait
      } else {
        return 2; // Mobile portrait
      }
    }
  }
}
