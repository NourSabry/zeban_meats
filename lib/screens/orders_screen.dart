import 'package:flutter/material.dart';
import '../widgets/order_widget.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';
import '../providers/order.dart';

class OrderScreen extends StatelessWidget {
  static final routeName = "/order-screen";

  @override
  Widget build(BuildContext context) {
    Future<List<Order>> orders =
        Provider.of<OrderProvider>(context, listen: false).fetchAllOrders();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Color(0xFFca4153)),
        title: Text(
          "طلباتى",
          style: TextStyle(
            fontSize: 28.0,
            fontFamily: "header",
            fontWeight: FontWeight.w900,
            color: Color(0xFFca4153),
          ),
        ),
      ),
      body: FutureBuilder(
          future: orders,
          builder: (context, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 0.5,
              ));
            }
            if (dataSnapShot.error != null) {
              return Center(
                child: Text('An error occurred'),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(5.0),
              child: dataSnapShot.data.isEmpty || dataSnapShot.data.length == 0
                  ? Center(
                      child: Text(
                      " لم يتم إضافة أى طلبات",
                      style: TextStyle(
                          color: Color(0xFFca4153),
                          fontSize: 20.0,
                          fontFamily: "amiri",
                          fontWeight: FontWeight.w600),
                    ))
                  : ListView.builder(
                      itemCount: dataSnapShot.data.length,
                      itemBuilder: (context, index) {
                        return OrderWidget(
                          order: dataSnapShot.data[index],
                        );
                      }),
            );
          }),
    );
  }
}
