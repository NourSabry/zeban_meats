import 'package:flutter/material.dart';
import 'package:mansour/providers/category.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import 'product_item_widget.dart';

class ProductsGrid extends StatelessWidget {
  final List<Category> categories;
  ProductsGrid({this.categories});
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Products>(context, listen: false).allItems;

    return categories.length == 0 || categories.isEmpty
        ? Center(
            child: Text(
            "لم يتم اضافة منتجات",
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF8d2424),
            ),
          ))
        : SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,

              // mainAxisSpacing: 2.0,
              // crossAxisSpacing: 2.0,
              childAspectRatio: 2 / 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  value: categories[index],
                  child: ProductItem(),
                );
              },
              childCount: categories.length,
            ),
          );
  }
}

// return GridView.builder(
//     shrinkWrap: true,
//     physics: const ClampingScrollPhysics(),
//     padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
//     itemCount: products.length,
//     itemBuilder: (context, index) {

//       return ChangeNotifierProvider.value(
//         value: products[index],
//         child: ProductItem(
//         ),
//       );
//     },
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       childAspectRatio: 2/3,
//       crossAxisSpacing: 5.0,
//       mainAxisSpacing: 5.0,
//     ),
//     );