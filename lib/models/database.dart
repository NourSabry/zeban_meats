

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../providers/card_item.dart';


class DBProvider{

  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;


  Future<Database> get database async{

    if(_database != null )
      return _database;

    _database = await initDB();
    return _database;

  }

  initDB () async{
    return await openDatabase(
      join(await getDatabasesPath(), "cart_items.db"),
      onCreate: (db, version)async{
        await db.execute('''
        CREATE TABLE CARTITEMS (
        id String PRIMARY KEY,
        productId INTEGER,
        coveringMethod String,
        selectedProductIndex INTEGER,
        selectedCuttingOption INTEGER,
        selectedProduct String,
        cuttingOption String,
        cuttingType String,
        maphromeFlag INTEGER,
        title String,
        notes String, 
        categoryID INTEGER,
        quantity INTEGER, 
        productName String,
        beafQuantity INTEGER,
        productPrice Integer,
        totalPrice INTEGER,
        aliveDeliveryForm INTEGER, 
        options String,
        imagePath String,
        savedImage INTEGER,
        groupValues String
        
        )
          '''
        );
      },
      version: 1,

    );
  }

  Map<String, dynamic> toMap(Item cardItem) {
    return {
      "id": cardItem.id,
      "productId":cardItem.productId,
      "selectedProductIndex": cardItem.selectedProductIndex,
      "selectedCuttingOption": cardItem.selectedCuttingOption,
      "selectedProduct": cardItem.selectedProduct,
      "cuttingOption": cardItem.cuttingOption,
      "cuttingType": cardItem.cuttingType,
      "maphromeFlag": cardItem.maphromeFlag,
      "productPrice": cardItem.productPrice,
      "coveringMethod": cardItem.coveringMethod,
    "title": cardItem.title,
    "notes": cardItem.notes,
    "categoryID": cardItem.categoryID,
    "quantity": cardItem.quantity,
    "productName": cardItem.productName,
    "beafQuantity": cardItem.beafQuantity,
    "totalPrice": cardItem.totalPrice,
    "aliveDeliveryForm": cardItem.aliveDeliveryForm,
    "options": cardItem.options,
    "imagePath": cardItem.imagePath,
    "savedImage":cardItem.savedImage,
    "groupValues": cardItem.groupValues
    
  };}


    Future<void> insertItem(Item cardItem) async {
      // Get a reference to the database.
      final Database db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'CARTITEMS',
        toMap(cardItem),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }


  // Future<dynamic> getCardItem(int id) async{
  //   final db = await database;
  //
  //   var response = await db.query("CARTITEM",where: "id = ?", whereArgs: [id]);
  //   return response.isNotEmpty ? response.first : Null ;
  // }

  Future<List<Item>> getAllCardItems() async{
    final db = await database;

    List<Map> response = await db.rawQuery('SELECT * FROM CARTITEMS');

    List<Item> items = [];
    response.forEach((element) { items.add(Item(
      savedImage: element["savedImage"],
      productId: element["productId"],
      coveringMethod: element["coveringMethod"],
      id: element["id"],
      title: element["title"],
      notes: element["notes"],
      categoryID: element["categoryID"],
      quantity: element["quantity"],
      productName: element["productName"],
      beafQuantity: element["beafQuantity"],
      totalPrice: element["totalPrice"],
        productPrice: element["productPrice"],
      aliveDeliveryForm: element["aliveDeliveryForm"],
      options: element["options"],
      selectedProductIndex:  element["selectedProductIndex"],
      selectedCuttingOption:  element["selectedCuttingOption"],
      cuttingOption: element["cuttingOption"],
      cuttingType: element["cuttingType"],
      imagePath: element["imagePath"],
      maphromeFlag: element["maphromeFlag"],
      selectedProduct: element["selectedProduct"],
      groupValues: element["groupValues"]

    )
    );});
    return items;
  }

  deleteCardItem(String id) async{
    final db = await database;
    var response = await db.delete("CARTITEMS",where: "id = ?", whereArgs: [id]);
    return response;
  }

  updateCardItem(Item cardItem) async{
    final db = await database;
    var response =  await db.update(
      'CARTITEMS',
      toMap(cardItem),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [cardItem.id],
    );
    return response;
  }

  deleteAllRows()async{
    final db = await database;
    var response = await db.delete('CARTITEMS');
    return response;
  }


}