import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Consumer<ProductProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Badge(
                  alignment: AlignmentDirectional.center,
                  isLabelVisible: value.productBag.isEmpty ? false : true,
                  label: Text(value.productBag.length.toString()),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/cart'),
                    // icon: Icons.shopping_bag_outlined,
                    // color: Colors.black,
                    // size: 40,
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Shoping',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<ProductProvider>(builder: (context, value, child) {
        if (value.isLoading == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: value.products.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: NetworkImage(value.products[index].image)),
                      const SizedBox(height: 10),
                      Text(value.products[index].title),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.products[index].price.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(width: 5),
                              Text(value.products[index].ratings.count
                                  .toString()),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: value.productBag.contains(value.products[index])
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.blue),
                                ),
                                onPressed: () {
                                  value.removeProductToCard(index);
                                },
                                child: const Text(
                                  'Remove From Card',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            : ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue)),
                                onPressed: () {
                                  value.addProductToCard(index);
                                },
                                child: const Text(
                                  'Buy',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
          );

          // StaggeredGridTile.fit(
          //       crossAxisCellCount: 2,
          //       child: Text('hi'),
          //     ),

          // return ListView.builder(
          //     itemCount: value.products.length,
          //     itemBuilder: (context, int index) {
          //       // return Text(value.products[index].image);
          //       return Card(
          //         child:
          //             Image(image: NetworkImage(value.products[index].image)),
          //       );
          //     });
        }
      }),
    );
  }
}
