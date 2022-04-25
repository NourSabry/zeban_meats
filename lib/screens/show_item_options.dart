import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/menu_button.dart';
import 'card_screen.dart';
import '../providers/category.dart';
import 'package:provider/provider.dart';
import '../providers/category_product.dart';
import '../widgets/quantity_card.dart';
import '../widgets/cutting_radio_buttons.dart';
import '../widgets/radio_buttons.dart';
import '../providers/card_provider.dart';
import '../providers/settings.dart';
import '../providers/card_item.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import '../models/local_image.dart';

class ShowItemOption extends StatefulWidget {
  static final routeName = '/show-item-options';

  @override
  _ShowItemOptionState createState() => _ShowItemOptionState();
}

class _ShowItemOptionState extends State<ShowItemOption> {
  int categoryId;
  int index = 0;
  bool snackFlag = false;
  bool _isLoading = false;
  String id = Uuid().v1();

  Future<Categorydetails> categoryDetails;
  Item itemOptions;

  List<Map<String, dynamic>> options = [];
  List<Map<String, dynamic>> optionsGroupValue = [];

  final notesController = TextEditingController();
  final quantityController = TextEditingController();

  String imageUrl;
  String title;

  @override
  void initState() {
    notesController.addListener(_updateNotes);
    quantityController.addListener(_updateQuantity);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Settings settings = ModalRoute.of(context).settings.arguments;
    categoryId = settings.id;
    imageUrl = settings.imageURL;
    title = settings.title;
    if (categoryDetails == null) {
      categoryDetails = Provider.of<Category>(context, listen: false)
          .fetchAndStoreCategoryDetails(categoryId);
    }
    if (itemOptions == null) {
      itemOptions = Item(
        id: id,
        productId: -1,
        categoryID: categoryId,
        selectedProduct: "",
        selectedCuttingOption: 0,
        cuttingType: "",
        maphromeFlag: 0,
        coveringMethod: "",
        cuttingOption: "",
        selectedProductIndex: 0,
        productName: "",
        title: title,
        imagePath: imageUrl,
        totalPrice: 0,
        notes: "",
        beafQuantity: 0,
        options: "",
        aliveDeliveryForm: 0,
        quantity: 1,
        savedImage: 0,
        groupValues: "",
      );
    }

    super.didChangeDependencies();
  }

  void updateQuantity(int value, int total) {
    setState(() {
      itemOptions.quantity = value;
      itemOptions.totalPrice = total;
    });
  }

  void updateProductIndex(String x, int index) {
    setState(() {
      itemOptions.selectedProductIndex = index;
      itemOptions.selectedProduct = x;
    });
  }

  void updateOptionsGroupValue(Map<String, dynamic> x) {
    var found = false;
    optionsGroupValue.forEach((element) {
      if (element["option_name"] == x["option_name"]) {
        found = true;
        element["option_value"] = x["option_value"];
      }
    });
    if (!found) {
      optionsGroupValue.add(x);
    }
  }

  void updateCuttingOption(dynamic x, int index) {
    setState(() {
      itemOptions.selectedCuttingOption = index;
      itemOptions.cuttingOption = x;
      updateOptions({
        "option_name": "التقطيع",
        "option_value": itemOptions.cuttingOption
      });
      updateOptionsGroupValue({
        "option_name": "طريقة التقطيع",
        "option_value": itemOptions.cuttingOption
      });
    });
  }

  void updateCuttingType(dynamic x) {
    setState(() {
      itemOptions.cuttingType = x;
      updateOptions({
        "option_name": "نوع الذبح",
        "option_value": itemOptions.cuttingType
      });
    });
  }

  void updateCoveringMethod(dynamic x) {
    setState(() {
      itemOptions.coveringMethod = x["option_value"];
    });
  }

  void updateOptions(Map<String, dynamic> x) {
    var found = false;
    setState(() {
      if (x["option_name"] == "مفروم") {
        if (x["option_value"] == "نعم") {
          itemOptions.maphromeFlag = 1;
        } else {
          itemOptions.maphromeFlag = 0;
          itemOptions.beafQuantity = 0;
        }
      }

      options.forEach((element) {
        if (element["option_name"] == x["option_name"]) {
          found = true;
          element["option_value"] = x["option_value"];
        }
      });
      if (!found) {
        options.add(x);
      }
    });
  }

  void finalUpdateOptions() {
    if (itemOptions.cuttingType != "مذبوح") {
      options.removeWhere((element) => element["option_name"] != "نوع الذبح");
      optionsGroupValue.clear();
      itemOptions.coveringMethod = "";
      itemOptions.beafQuantity = 0;
    }
  }

  void generateoptionsString() {
    setState(() {
      finalUpdateOptions();
      options.forEach((element) {
        String temp = "";
        element.forEach((key, value) {
          temp = temp + '"$key":"${value.toString()}",';
        });
        temp = temp.substring(0, temp.length - 1);
        itemOptions.options = itemOptions.options + "{$temp}" + "/";
      });

      optionsGroupValue.forEach((element) {
        String temp = "";
        element.forEach((key, value) {
          temp = temp + '"$key":"${value.toString()}",';
        });

        temp = temp.substring(0, temp.length - 1);

        itemOptions.groupValues = itemOptions.groupValues + "{$temp}" + "/";
      });

      itemOptions.groupValues = itemOptions.groupValues.length == 0
          ? ""
          : '${itemOptions.groupValues.substring(0, itemOptions.groupValues.length - 1)}';
      itemOptions.options =
          '${itemOptions.options.substring(0, itemOptions.options.length - 1)}';
    });
  }

  void _updateNotes() {
    setState(() {
      itemOptions.notes = notesController.text;
    });
  }

  void extractOptions() {
    if (itemOptions.groupValues != "") {
      var temp = itemOptions.groupValues.split("/");
      temp.forEach((element) {
        if (element != null) {
          var value = json.decode(element);

          optionsGroupValue.add(value);
        }
      });
    }
  }

  void _updateQuantity() {
    try {
      setState(() {
        itemOptions.beafQuantity =
            int.parse(quantityController.text.toString());
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    notesController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cardProvider = Provider.of<CardProvider>(context);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Color(0xFFca4153)),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 25.0,
              fontFamily: "header",
              fontWeight: FontWeight.w900,
              color: Color(0xFFca4153)),
        ),
      ),
      body: FutureBuilder<Categorydetails>(
        future: categoryDetails,
        builder: (context, AsyncSnapshot<Categorydetails> snapshot) =>
            _isLoading == false &&
                    snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null
                ? Container(
                    // margin: const EdgeInsets.all(2.0),
                    // padding: const EdgeInsets.all(2.0),
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            QuantityCard(
                              quantity: itemOptions.quantity,
                              updateValue: updateQuantity,
                              price: snapshot.data.products.isEmpty ||
                                      itemOptions.selectedProductIndex == 0
                                  ? 0
                                  : snapshot.data.products[
                                          itemOptions.selectedProductIndex - 1]
                                      ["price"],
                            ),
                            snapshot.data.products.isEmpty
                                ? Center(
                                    child: Text(
                                      "لم يتم اضافه أحجام لهذا المنتج",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF8d2424),
                                      ),
                                    ),
                                  )
                                : Card(
                                    color: Colors.white,
                                    elevation: 8.0,
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: MenuButton(
                                        title: "الحجم المطلوب",
                                        values: <String>[
                                          ...snapshot.data.products
                                              .map((item) => item["name"])
                                              .toList()
                                        ],
                                        updateValue: updateProductIndex,
                                        selectedItemIndex:
                                            itemOptions.selectedProductIndex,
                                      ),
                                    ),
                                  ),
                            Card(
                              color: Colors.white,
                              elevation: 8.0,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "نوع الذبح",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "amiri",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFca4153),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Card(
                                      color: Colors.white,
                                      elevation: 5.0,
                                      child: CuttingRadioButtons(
                                        updateValue: updateCuttingType,
                                      ),
                                    ),
                                    if (itemOptions.cuttingType == "مذبوح")
                                      ...snapshot.data.options.map((
                                        item,
                                      ) {
                                        if (item.name == "طريقة التقطيع") {
                                          return MenuButton(
                                            title: item.name,
                                            values: item.values,
                                            updateValue: updateCuttingOption,
                                            selectedItemIndex: itemOptions
                                                .selectedCuttingOption,
                                          );
                                        }

                                        return RadioButtons(
                                          updateValue: updateOptions,
                                          itemValues: {
                                            "option_name": item.name,
                                            "option_values": item.values,
                                          },
                                          title: item.name,
                                          groupValue: optionsGroupValue.length >
                                                  0
                                              ? optionsGroupValue
                                                      .map((e) {
                                                        if (e["option_name"] ==
                                                            item.name) {
                                                          index =
                                                              optionsGroupValue
                                                                  .indexOf(e);
                                                          return e[
                                                              "option_value"];
                                                        }
                                                      })
                                                      .toList()[index]
                                                      .toString() ??
                                                  ""
                                              : "",
                                          updateGroupValue:
                                              updateOptionsGroupValue,
                                        );
                                      }).toList(),
                                    itemOptions.maphromeFlag == 0
                                        ? SizedBox(
                                            height: 0.0,
                                            width: 0.0,
                                          )
                                        : Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "كم كيلو ؟",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: "amiri",
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF8d2424),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Container(
                                                  height: 50.0,
                                                  width: 100.0,
                                                  decoration: BoxDecoration(
                                                      // color: Color(0x99353b48),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: .5,
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: TextField(
                                                    enableSuggestions: false,
                                                    autocorrect: false,
                                                    controller:
                                                        quantityController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (newValue) {
                                                      _updateQuantity();
                                                    },
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: "amiri",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xbb8d2424),
                                                    ),
                                                    textAlign: TextAlign.right,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      // hintText: "ضع ملاحظاتك هنا",
                                                      labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF8d2424),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                    itemOptions.cuttingOption == "ثلاجة" &&
                                            itemOptions.cuttingType == "مذبوح"
                                        ? RadioButtons(
                                            updateValue: updateOptions,
                                            updateGroupValue:
                                                updateCoveringMethod,
                                            groupValue: options.length > 0
                                                ? options
                                                        .map((e) {
                                                          if (e["option_name"] ==
                                                              "طريقة التغليف") {
                                                            index = options
                                                                .indexOf(e);
                                                            return e[
                                                                "option_value"];
                                                          }
                                                        })
                                                        .toList()[index]
                                                        .toString() ??
                                                    ""
                                                : "",
                                            itemValues: {
                                              "option_name": "طريقة التغليف",
                                              "option_values": [
                                                "مغلف",
                                                "بدون تغليف",
                                                "تكييس",
                                                "شفط هواء"
                                              ]
                                            },
                                            title: "طريقة التغليف",
                                          )
                                        : SizedBox(
                                            height: 0.0,
                                            width: 0.0,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              elevation: 8.0,
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "ملاحظات الطلب",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "amiri",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFca4153),
                                      ),
                                    ),
                                    Container(
// width: MediaQuery.of(context).size.width - 100,

                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: .5,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: TextField(
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        onChanged: (newValue) {
                                          _updateNotes();
                                        },
                                        textAlign: TextAlign.right,
                                        keyboardType: TextInputType.multiline,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "amiri",
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xbb8d2424),
                                        ),
                                        textInputAction:
                                            TextInputAction.newline,
                                        maxLines: null,
                                        controller: notesController,
                                        decoration: InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.all(5.0),
// labelText: "ملاحظات الطلب",
                                          hintText: "ضع ملاحظاتك هنا",

                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8d2424),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Center(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    elevation: 10, primary: Color(0xFF8d2424)),
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                ),
                                label: Text("أضف للسلة"),
                                onPressed: () async {
                                  var snackBar;
                                  if (itemOptions.selectedProductIndex == 0) {
                                    snackBar = SnackBar(
                                        content: Text('يجب أختيار الحجم'));
                                  } else if (itemOptions.cuttingType == "") {
                                    snackBar = SnackBar(
                                        content: Text('يجب أختيار نوع الذبح'));
                                  } else if (itemOptions.cuttingType ==
                                      "مذبوح") {
                                    if (itemOptions.selectedCuttingOption ==
                                        0) {
                                      snackBar = SnackBar(
                                          content:
                                              Text('يجب أختيار طريقة التقطيع'));
                                    } else if (itemOptions.maphromeFlag == 1 &&
                                        itemOptions.beafQuantity == 0) {
                                      snackBar = SnackBar(
                                          content:
                                              Text('يجب إدخال كمية المفروم'));
                                    } else if (optionsGroupValue.length == 0 ||
                                        optionsGroupValue.length <
                                            snapshot.data.options.length) {
                                      snackBar = SnackBar(
                                          backgroundColor: Color(0xFFca4153)
                                              .withOpacity(0.01),
                                          content:
                                              Text('يجب تحديد الاختيارات'));
                                    }
                                  }

                                  if (snackBar != null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    itemOptions.totalPrice = itemOptions
                                            .quantity *
                                        snapshot.data.products[
                                            itemOptions.selectedProductIndex -
                                                1]["price"];
                                    itemOptions.aliveDeliveryForm =
                                        itemOptions.cuttingType == "مذبوح"
                                            ? 0
                                            : 1;
                                    if (itemOptions.savedImage == 0) {
                                      SaveFile save = SaveFile();
                                      itemOptions.imagePath =
                                          await save.saveImage(
                                              id: categoryId,
                                              url: itemOptions.imagePath);
                                      itemOptions.savedImage = 1;
                                    }

                                    generateoptionsString();
                                    itemOptions.productPrice =
                                        snapshot.data.products[
                                            itemOptions.selectedProductIndex -
                                                1]["price"];
                                    itemOptions.productName =
                                        snapshot.data.products[
                                            itemOptions.selectedProductIndex -
                                                1]["name"];
                                    itemOptions.productId =
                                        snapshot.data.products[
                                            itemOptions.selectedProductIndex -
                                                1]["id"];
                                    await cardProvider.addItem(itemOptions);
                                    Navigator.popAndPushNamed(
                                      context,
                                      CartScreen.routeName,
                                    );
                                    // setState(() {
                                    //   _isLoading = true;
                                    // });
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 0.5,
                    ),
                  ),
      ),
    );
  }
}
