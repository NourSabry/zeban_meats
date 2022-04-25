import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'category_product.dart';
import 'option.dart';

class Category with ChangeNotifier{
  final int id;
  final String name;
  final String imageUrl;
  Category({this.id,this.name,this.imageUrl});


  // Categorydetails categoryDetails;
  // Categorydetails get getCategoryDetails{
  //   return  categoryDetails;
  // }

  Future<Categorydetails> fetchAndStoreCategoryDetails(int categoryId) async{
    var url = Uri.parse("https://meatstoreapi.herokuapp.com/category/$categoryId");

    var respose = await http.get(url);
    var extractedData = json.decode(utf8.decode(respose.bodyBytes)) as Map<String,dynamic>;

    List<dynamic> options = extractedData["options"].map((item) => Option(
        name: item["option_name"]["name"],
        values: <String>[...item["option_values"].map((optionValue) => optionValue["value"]).toList()],
      )
    ).toList();

    Categorydetails categoryDetails =  Categorydetails(
      categoryId: extractedData["id"],
      categoryName: extractedData["name"],
      products: extractedData["products"],
      options: options,
      quantity: 1,

    );

return categoryDetails;


  }
}



