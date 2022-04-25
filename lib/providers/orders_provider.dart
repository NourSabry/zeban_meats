import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'order.dart';
import '../models/device_id.dart';

class OrderProvider with ChangeNotifier {
  DeviceUniqueId id = DeviceUniqueId();


  List<Order> _orders = [];




  Future<void> addOrder(Order order)async{
    var url = Uri.parse("https://meatstoreapi.herokuapp.com/order/");
    String uniqueID = await id.getId();

    try {

      await http.post(url,
          headers: {"Content-Type": "application/json", 'Accept': 'application/json'},
          body: json.encode({
            "cart": {
              "item": order.cart.item.map((element) {
                return {
                  "product": element.product,
                  "variants": element.variants,
                  "quantity": element.quantity,
                  "total_price": element.totalPrice,
                  "notes": element.notes,
                  "beef_quantity": element.beefQuantity,
                  "fridge_status": element.fridgeStatus,
                  "alive_delivery_form": element.aliveDeliveryForm,

                };
              }).toList(),
              "total_amount":0,
            },
            "name":order.name,
            "address":order.address,
            "phone":order.phone,
            "payment_method": order.paymentMethod,
            "order_confirmation_method": order.orderConfirmation,
            "session_id": uniqueID,

          }),
      );


    }catch(e){
print(e.toString());
    }
  }


  Future<List<Order>> fetchAllOrders()async{
    String uniqueID = await id.getId();
    var url = Uri.parse("https://meatstoreapi.herokuapp.com/order/$uniqueID");
try{

  var response = await http.get(url);

    var extractedData = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    List<Order> _loadedOrders =[];
    if (extractedData == null){
      return _orders;
    }


   extractedData.forEach((item) {

      var x = item["cart"]["item"] as List<dynamic>;

      try{
      _loadedOrders.add(Order(
        id: item["id"],
        name: item["name"],
        address: item["address"],
        phone: item["phone"],
        paymentMethod: item["payment_method"],
        orderConfirmation: item["order_confirmation_method"],
        cart: CartModel(
          id: item["cart"]["id"],
          totalAmount: item["cart"]["total_amount"],
          item: x.map((element) {

            return SubCartItem(
              id: element["id"],
              variants:   element["variants"] ,
              totalPrice: element["total_price"],
              notes: element["notes"],
              fridgeStatus: element["fridge_status"],
              category: element["category"],
              beefQuantity: element["beef_quantity"],
              product: element["product"],
              aliveDeliveryForm: element["alive_delivery_form"],
              quantity: element["quantity"],
            );
          } ).toList(),
        ),

      )) ;

      }catch(e){

      }
      // print(x);

    });
    _orders = _loadedOrders;
    // print(_items);
    notifyListeners();
    return _orders;

}catch(e){}

  }

}