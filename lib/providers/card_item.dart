import 'package:flutter/foundation.dart';


class Item with ChangeNotifier {
   String id;
   int savedImage;
  int  categoryID;
  int productId;
  String coveringMethod;
  String productName;
  int selectedProductIndex;
  int selectedCuttingOption;
  String selectedProduct;
  String cuttingOption;
  String cuttingType;
  int maphromeFlag;
  String title;
  int quantity;
  int productPrice;
  int aliveDeliveryForm;
  String notes;
  int beafQuantity;
  String options;
  int totalPrice;
  String imagePath;
  String groupValues;

  Item({
    this.id,
    this.productId,
    this.coveringMethod,
    this.selectedProductIndex,
    this.selectedCuttingOption,
    this.selectedProduct,
    this.cuttingType,
    this.cuttingOption,
    this.maphromeFlag,
    this.options,
    this.quantity,
    this.categoryID,
    this.aliveDeliveryForm,
    this.beafQuantity,
    this.notes,
    this.productName,
    this.productPrice,
    this.totalPrice,
    this.title,
    this.imagePath,
    this.savedImage,
    this.groupValues
  });
}
