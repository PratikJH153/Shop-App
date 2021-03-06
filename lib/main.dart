import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/views/auth_screen.dart';
import 'package:shopapp/views/cart_page.dart';
import 'package:shopapp/views/edit_product_page.dart';
import 'package:shopapp/views/orders_page.dart';
import 'package:shopapp/views/user_products_page.dart';

import '../providers/products.dart';
import '../views/product_details_page.dart';
import '../views/products_overiew_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
          create: (ctx) => Products('', []),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
          create: (ctx) => Orders("", []),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shop App",
          theme: ThemeData(
            primarySwatch: Colors.purple,
            errorColor: Colors.red,
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
            ),
          ),
          home: auth.isAuth ? const ProductsOverviewPage() : const AuthScreen(),
          routes: {
            AuthScreen.routeName: (ctx) => const AuthScreen(),
            ProductsOverviewPage.routeName: (ctx) =>
                const ProductsOverviewPage(),
            ProductDetailsPage.routeName: (ctx) => const ProductDetailsPage(),
            CartPage.routeName: (ctx) => const CartPage(),
            OrdersPage.routeName: (ctx) => const OrdersPage(),
            UserProductsPage.routeName: (ctx) => const UserProductsPage(),
            EditProductPage.routeName: (ctx) => const EditProductPage(),
          },
        ),
      ),
    );
  }
}
