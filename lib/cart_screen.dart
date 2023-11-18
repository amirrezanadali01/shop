import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models.dart';
import 'package:shop/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  static const String routname = '/cart';

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      bottomSheet: const Padding(
        padding: EdgeInsets.only(bottom: 22, left: 15, right: 15),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              child: Text(
                'Pay',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              )),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: value.productBag.length,
                itemBuilder: (context, indext) {
                  ProductsModel product = value.productBag[indext];
                  return CardOfCart(
                    title: product.title,
                    image: product.image,
                    description: product.description,
                    price: product.price.toString(),
                    removeProduct: () {
                      value.removeProductToCard(product);
                      if (value.productBag.isEmpty) {
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
          );
        },
      ),
    );
  }
}

class CardOfCart extends StatelessWidget {
  const CardOfCart({
    required this.description,
    required this.image,
    required this.price,
    required this.removeProduct,
    required this.title,
    super.key,
  });

  final String image;
  final String title;
  final String description;
  final String price;
  final Function()? removeProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Image(
                  image: NetworkImage(
                image,
              )),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$price \$",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                          onPressed: removeProduct,
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
