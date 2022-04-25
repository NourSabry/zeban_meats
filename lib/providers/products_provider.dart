import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:mansour/providers/category.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier{


List<Category> _items =[];

  List<Category> get allItems{
    return [..._items];
}

Future<List<Category>> fetchAndStoreCategories() async{

    var url = Uri.parse("https://meatstoreapi.herokuapp.com/category/");


    try{
      var response = await http.get(url);

      var extractedData = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

      List<Category> _loadedProducts =[];
      if (extractedData == null){
        return _items;
      }
      extractedData.forEach((item) {
        _loadedProducts.add(
            Category(
              id: item["id"],
              name: item["name"],
              imageUrl:
              item["image"]==null ?
              "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg"
                  : item["image"]
              ,
            ));
      });

      _items = _loadedProducts;
      // print(_items);
      notifyListeners();

    }catch(error){

      throw error;
    }

    return _items;


}




}

//
// List <Product> items = [Product(id: "1",description: "950",title: "shoun the ship",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "1200",title: "نجدى",imageUrl: "https://cdn.sabq.org/uploads/media-cache/resize_800_relative/uploads/material-file/59d91d8bef9d1439e58b4592/59d91e31708ec.jpg",),
//   Product(id: "13",description: "1150",title: "نصف ذبيحه نعيمى",imageUrl: "https://cdn.sabq.org/uploads/media-cache/resize_800_relative/uploads/material-file/59d91d8bef9d1439e58b4592/59d91e31708ec.jpg",),
//   Product(id: "13",description: "1430",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "2100",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "2100",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "2100",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "1850",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//   Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),Product(id: "13",description: "not bad",title: "anything",imageUrl: "https://www.zamanalwsl.net/CustomImage/get/700/500/53f2dee633cf40db19d823d9.jpg",),
//
//
// ];