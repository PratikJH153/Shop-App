import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/views/edit_product_page.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';
import '../providers/products.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = "/userproducts";
  const UserProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductPage.routeName, arguments: "");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<Products>(
          builder: (ctx, products, _) {
            return ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    UserProductItem(
                      id: products.items[index].id,
                      title: products.items[index].title,
                      imageURL: products.items[index].imageUrl,
                    ),
                    const Divider(),
                  ],
                );
              },
              itemCount: products.items.length,
            );
          },
        ),
      ),
    );
  }
}
