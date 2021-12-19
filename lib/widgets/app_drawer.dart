import 'package:flutter/material.dart';
import 'package:shopapp/views/orders_page.dart';
import 'package:shopapp/views/products_overiew_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello Friend!"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductsOverviewPage.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersPage.routeName),
          ),
        ],
      ),
    );
  }
}
