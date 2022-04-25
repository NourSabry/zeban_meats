import 'package:flutter/material.dart';
import '../providers/order.dart';
import '../widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class OrderDetails extends StatelessWidget {
  static final routeName = "/order-details-screen";
  @override
  Widget build(BuildContext context) {
    var category = Provider.of<Products>(context, listen: false).allItems;
    Order order = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "شكرا لك",
          style: TextStyle(
              fontSize: 28.0,
              fontFamily: "header",
              fontWeight: FontWeight.w900,
              color: Color(0xFF915f3a)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: Colors.white70,
                elevation: 8.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40.0,
                  child: Center(
                      child: Text(
                    "تفاصيل الطلب",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8d2424),
                    ),
                  )),
                ),
              ),
              ...order.cart.item.map((element) {
                return Container(
                  height: 350.0,
                  child: Card(
                    color: Colors.white,
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 2,
                              child: TextWidget(
                                title: "النوع",
                                value: category[category.indexWhere(
                                        (e) => e.id == element.category)]
                                    .name,
                              )),
                          Expanded(
                              flex: 2,
                              child: TextWidget(
                                title: "نوع الذبح",
                                value:
                                    element.aliveDeliveryForm ? "حي" : "مذبوح",
                              )),
                          ...element.variants.map(
                            (e) => Expanded(
                                flex: 2,
                                child: TextWidget(
                                    title: e["option_name"]["name"],
                                    value: e["option_value"]["value"])),
                          ),
                          element.fridgeStatus != ""
                              ? Expanded(
                                  flex: 2,
                                  child: TextWidget(
                                    title: "طريقة التغليف",
                                    value: element.fridgeStatus,
                                  ))
                              : SizedBox(
                                  height: 0.0,
                                ),
                          element.beefQuantity != 0
                              ? Expanded(
                                  flex: 2,
                                  child: TextWidget(
                                    title: "كمية المفروم",
                                    value: element.beefQuantity.toString(),
                                  ))
                              : SizedBox(
                                  height: 0.0,
                                ),
                          Divider(
                            height: 20.0,
                            thickness: 0.5,
                            color: Colors.blueGrey,
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 50.0,
                                  width: 80.0,
                                  child: Card(
                                    color: Colors.white54,
                                    elevation: 5.0,
                                    child: Center(
                                      child: Text(
                                        element.quantity.toString(),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF8d2424),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  "الكمية",
                                  style: TextStyle(
                                    color: Color(0xFF915f3a),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 20.0,
                            thickness: 0.5,
                            color: Colors.blueGrey,
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "الاجمالى ${element.totalPrice} ر.س ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "lateef",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8d2424),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              Card(
                color: Colors.white70,
                elevation: 8.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40.0,
                  child: Center(
                      child: Text(
                    "تفاصيل الشحن",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8d2424)),
                  )),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextWidget(
                        title: "الاسم",
                        value: order.name,
                      ),
                      SizedBox(height: 10.0),
                      TextWidget(
                        title: "العنوان",
                        value: order.address,
                      ),
                      SizedBox(height: 10.0),
                      TextWidget(
                        title: "المدينه",
                        value: "الرياض",
                      ),
                      SizedBox(height: 10.0),
                      TextWidget(
                        title: "رقم الجوال",
                        value: order.phone.toString(),
                      ),
                      SizedBox(height: 10.0),
                      TextWidget(
                        title: "طريقة تأكيد الطلب",
                        value: order.orderConfirmation,
                      ),
                      SizedBox(height: 10.0),
                      TextWidget(
                        title: "طريقة الدفع",
                        value: order.paymentMethod,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                child: Container(
                  height: 40.0,
                  child: Center(
                    child: Text(
                      "اجمالى الطلب ${order.cart.totalAmount} ر.س ",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "lateef",
                          color: Color(0xFF8d2424)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
