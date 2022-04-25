import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/card_widget.dart';
import '../providers/card_item.dart';
import '../providers/card_provider.dart';
import 'all_products_screen.dart';
import 'info_screen.dart';
import '../providers/order.dart';
import 'dart:convert';

class CartScreen extends StatelessWidget {
  static final routeName = '/card-screen';

  extractOptions(String groupValues) {
    List<Map<String, Map<String, String>>> options = [];
    if (groupValues != "") {
      var temp = groupValues.split("/");
      temp.forEach((element) {
        if (element != null) {
          var value = json.decode(element);
          options.add({
            "option_name": {"name": value["option_name"]},
            "option_value": {"value": value["option_value"]}
          });
        }
      });
    }
    return options;
  }

  Widget build(BuildContext context) {
    Future<List<Item>> cardProvider =
        Provider.of<CardProvider>(context, listen: false).getAllItems();

    var totalPrice = Provider.of<CardProvider>(
      context,
    ).totalPrice;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFca4153)),
        backgroundColor: Colors.white,
        title: Text(
          "سلة المشتريات",
          style: TextStyle(
              fontSize: 25.0,
              fontFamily: "header",
              fontWeight: FontWeight.w900,
              color: Color(0xFFca4153)),
        ),
      ),
      body: FutureBuilder<List<Item>>(
        future: cardProvider,
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Center(
              child: Text('An error occurred'),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: snapshot.data == null ||
                        snapshot.data.isEmpty ||
                        snapshot.data.length == 0
                    ? Center(
                        child: Text(
                          'لم يتم إضافه منتجات إلى السلة',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFFca4153),
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              return ChangeNotifierProvider.value(
                                  value: snapshot.data[index],
                                  child: CardItem());
                            }),
                      ),
              ),
              // Divider(height: 10.0,color: Colors.black,thickness: 2.0,),
              Expanded(
                flex: 1,
                child: Card(
                  color: Colors.white,
                  elevation: 8.0,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "المجموع الكلى $totalPrice ر.س ",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8d2424),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 120.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (snapshot.data.length > 0) {
                                      Navigator.pushNamed(
                                          context, InfoScreen.routeName,
                                          arguments: Order(
                                              name: "",
                                              address: "",
                                              paymentMethod: "",
                                              phone: 000000000,
                                              cart: CartModel(
                                                item: snapshot.data.map((item) {
                                                  return SubCartItem(
                                                    notes: item.notes,
                                                    quantity: item.quantity,
                                                    aliveDeliveryForm:
                                                        item.aliveDeliveryForm ==
                                                                0
                                                            ? false
                                                            : true,
                                                    beefQuantity:
                                                        item.beafQuantity,
                                                    category: item.categoryID,
                                                    fridgeStatus:
                                                        item.coveringMethod,
                                                    totalPrice: item.totalPrice,
                                                    product: {
                                                      "id": item.productId,
                                                      "name": item.productName,
                                                      "price":
                                                          item.productPrice,
                                                    },
                                                    variants: extractOptions(
                                                        item.groupValues),
                                                  );
                                                }).toList(),
                                                totalAmount: totalPrice,
                                              )));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "برجاء إضافة منتجات إلى السلة",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              backgroundColor:
                                                  Color(0xFFca4153)));
                                    }
                                  },
                                  child: Text(
                                    "إتمام الطلب",
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFca4153),
                                    textStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 120.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        ProductsScreen.routeName,
                                        (Route<dynamic> route) => false);
                                    // Navigator.popUntil(
                                    //     context, ModalRoute.withName('/'));
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (BuildContext context) =>
                                    //           ProductsScreen(),
                                    //     ));
                                    Navigator.pushNamed(
                                        context, ProductsScreen.routeName);
                                  },
                                  child: Text("إضافة المزيد"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFca4153),
                                    textStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white70),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
