import 'package:flutter/material.dart';
import 'package:mansour/providers/order.dart';
import 'package:provider/provider.dart';
import '../screens/order_details_screen.dart';
import '../widgets/text_widget.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  OrderWidget({this.order});

  @override
  Widget build(BuildContext context) {
    // var order = Provider.of<Order>(context,listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OrderDetails.routeName, arguments: order);
      },
      child: Container(
        height: 200.0,
        padding: const EdgeInsets.all(5.0),
        child: Card(
          color: Color.fromARGB(255, 250, 239, 239),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 15.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextWidget(
                  title: "اسم العميل",
                  value: order.name,
                ),
                TextWidget(
                  title: "العنوان",
                  value: order.address,
                ),
                TextWidget(
                  title: "رقم الجوال",
                  value: order.phone.toString(),
                ),
                TextWidget(
                  title: "طريقة الدفع",
                  value: order.paymentMethod,
                ),
                TextWidget(
                  title: "طريقة تأكيد الطلب",
                  value: order.orderConfirmation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
