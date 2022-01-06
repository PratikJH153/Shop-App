import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart' show Orders;
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_item.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  //! Different APPROACH IS BY USING FUTURE BULDER
  //* BUT A BETTER PRACTICE IS USING STATEFUL BECAUSE IS SOMETHING IS CHANGED IN THIS CLASS
  //* THE FUTURE BUILDER AGAIN FETCHES THE DATA WHICH WE DONT WANT

  Future? _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  // bool _isLoading = false;
  // @override
  // void initState() {
  //   //Also to fetch data while initializing but with a small change
  //   Future.delayed(Duration.zero).then((_) async {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     //We can call this without future delayed if the listen is false
  //     await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // AS FUTURE BULDER CALLS THE BUILD METHOD AND ALSO PROVIDER CALLS THE BUILD METHOD IT WILL RESULT IN INFINITE LOOP
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text("An error Occured"),
              );
            } else {
              return Consumer<Orders>(builder: (ctx, orderData, _) {
                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    return OrderItem(
                      order: orderData.orders[index],
                    );
                  },
                  itemCount: orderData.orders.length,
                );
              });
            }
          }
        },
      ),
    );
  }
}
