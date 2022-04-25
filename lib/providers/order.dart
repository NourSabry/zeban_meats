import'package:flutter/material.dart';


class SubCartItem{
  final int id;
  final List<dynamic> variants;
  final int quantity;
  final int totalPrice;
  final String notes;
  final int beefQuantity;
  final bool aliveDeliveryForm;
  final int category;
  final String fridgeStatus;
  final Map<String,dynamic> product;

  SubCartItem({
    this.id,
    this.variants,
    this.quantity,
    this.totalPrice,
    this.notes,
    this.beefQuantity,
    this.aliveDeliveryForm,
    this.category,
    this.product,
    this.fridgeStatus,
});
}

class CartModel {
  final int id;
  final List<SubCartItem> item;
  final int totalAmount;
  CartModel({this.id,this.item,this.totalAmount});

}

class Order with ChangeNotifier{
  final int id;
   String name;
   String address;
   String paymentMethod;
   int phone;
  String orderConfirmation;
  final CartModel cart;

  Order({
    this.id,
    this.name,
    this.address,
    this.paymentMethod,
    this.phone,
    this.cart,
    this.orderConfirmation
});
}