import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final productItems = Provider.of<ProductProvider>(context, listen: false);
      productItems.getAllProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(builder: (context, value, child) {
        if (value.isLoading == true) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
              itemCount: value.products.length,
              itemBuilder: (context, int index) {
                return Text(value.products[index].category);
              });
        }
      }),
    );
  }
}
