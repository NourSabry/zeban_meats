import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../widgets/side_drawer.dart';
import 'package:mansour/widgets/heigh_light_swipper.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../screens/card_screen.dart';
import '../providers/card_provider.dart';
import '../providers/category.dart';
import '../providers/slider_images.dart';
import '../widgets/badge.dart';

class ProductsScreen extends StatefulWidget {
  static final routeName = "/all-products";
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Future<List<Category>> allItems;
  Future<List<String>> images;

  @override
  void initState() {
    allItems =
        Provider.of<Products>(context, listen: false).fetchAndStoreCategories();

    images =
        Provider.of<SliderImages>(context, listen: false).getAllImagesUrl();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFca4153)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 8.0,
        title: Text(
          "ذيبان للذبائح",
          style: TextStyle(
              fontSize: 28.0,
              fontFamily: "header",
              fontWeight: FontWeight.w900,
              color: Color(0xFFca4153)),
        ),
        actions: [
          Consumer<CardProvider>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Color(0xFFca4153),
                size: 38.0,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: allItems,
        builder: (context, snapShot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: MediaQuery.of(context).size.height,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      child: FutureBuilder(
                          future: images,
                          builder: (context, snap) =>
                              snap.connectionState == ConnectionState.waiting ||
                                      !snapShot.hasData ||
                                      snapShot.data == null
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 0.5,
                                      ),
                                    )
                                  : HeighlightSwipper(
                                      images: snap.data,
                                    )),
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ]),
                ),
                !snapShot.hasData || snapShot.data.length == 0
                    ? SliverList(
                        delegate: SliverChildListDelegate([
                        Container(
                            height: MediaQuery.of(context).size.height * .5,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 0.5,
                              ),
                            ))
                      ]))
                    : ProductsGrid(
                        categories: snapShot.data,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
