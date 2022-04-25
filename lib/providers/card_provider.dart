import 'package:flutter/foundation.dart';
import '../models/database.dart';
import 'card_item.dart';


class CardProvider with ChangeNotifier{
  var dbProvider = DBProvider.db;

  List<Item> items =[];

  List<Item> get getItems{
    return [...items];
  }

  int get itemCount {
     getAllItems();
    return items.length;
  }
  int get totalPrice{
    int sum = 0;
    if(items.length ==0 || items.isEmpty){
      return 0;
    }else{
      items.forEach((element) { sum += element.totalPrice; });
      return sum;
    }

  }

  Future<void> addItem(Item cardItem) async{
    try{

    await dbProvider.insertItem(cardItem);
     }
     catch(error){

    }

    items.add(cardItem);
    notifyListeners();
  }

  Future<List<Item>> getAllItems() async{
    try{
     var response =  await dbProvider.getAllCardItems();
     items = response;
    }catch(error){

    }
    notifyListeners();
    return items;

  }

  Future<void> deleteItem(String id) async{
    try{
     dbProvider.deleteCardItem(id);
        items.removeWhere((element) => element.id == id);

    }catch(error){}
    notifyListeners();
  }

  Future<void> updateItem(Item item) async{

    try{
      var response = dbProvider.updateCardItem(item);
      if(response.statusCode == 200){
        int index = items.indexWhere((element) => element.id == item.id);
        items[index] = item;
      }
    }catch(e){}
    notifyListeners();
  }


  Future<void> deleteAll()async{

    try{
      var response = dbProvider.deleteAllRows();
      if(response.statusCode == 200){
        items = [];
      }
    }
    catch(e){}
    notifyListeners();

  }


}