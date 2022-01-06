import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/views/edit_product_page.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  const UserProductItem({
    required this.id,
    required this.title,
    required this.imageURL,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductPage.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (err) {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text("Delete Failed!"),
                    ),
                  );
                }
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
