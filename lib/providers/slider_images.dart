import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SliderImages with ChangeNotifier{

  List<String> _imageUrls = [];

  //  get allImageUrls{
  //   return [..._imageUrls];
  // }

  Future<List<String>> getAllImagesUrl()async{
    var url = Uri.parse('https://meatstoreapi.herokuapp.com/slider/');
    var response = await http.get(url);

    var extrractedData = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    List<String> urls = [];

    extrractedData.forEach((element) {
      urls.add(element["image"]);
    });
    _imageUrls = urls;
    notifyListeners();
    return _imageUrls;
  }
}