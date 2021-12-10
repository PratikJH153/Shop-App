import 'package:flutter/material.dart';
import 'package:shopapp/views/products_overiew_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shop App",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
      ),
      initialRoute: ProductsOverviewPage.routeName,
      routes: {
        ProductsOverviewPage.routeName: (ctx) => ProductsOverviewPage(),
      },
    );
  }
}
