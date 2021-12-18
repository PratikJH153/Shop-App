import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

import '../widgets/products_grid.dart';

enum PopMenuOptions {
  favorites,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  static const routeName = "/";
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => const [
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: PopMenuOptions.favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: PopMenuOptions.all,
              ),
            ],
            onSelected: (PopMenuOptions selectedValue) {
              setState(() {
                if (selectedValue == PopMenuOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ProductGrid(_showFavoritesOnly),
    );
  }
}
