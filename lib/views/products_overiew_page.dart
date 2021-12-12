import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  static const routeName = "/";
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
      ),
      body: const ProductGrid(),
    );
  }
}
