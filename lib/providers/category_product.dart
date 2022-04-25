import 'package:flutter/material.dart';


class Categorydetails with ChangeNotifier{
  final int categoryId;
  final String categoryName;
  final int quantity;
  final List<dynamic> products;
  final List<dynamic>options;


  Categorydetails({this.categoryId,this.categoryName,this.products,this.options,this.quantity});
}