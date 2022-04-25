import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../providers/card_item.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import 'text_widget.dart';
import 'quantity_card.dart';
import 'dart:io';

class CardItem extends StatelessWidget {

  final optionsList = [] ;
  void extractOptions(var options){
    var temp = options.split("/");
    temp.forEach((element) {

      if(element !=null) {
        var value = json.decode(element);

        optionsList.add(value);
      }



    });
  }



  @override
  Widget build(BuildContext context) {
    var item = Provider.of<Item>(context,);
    var cardProvider = Provider.of<CardProvider>(context);
    int price = item.productPrice;
    extractOptions(item.options);

    void updateQuantity(int value,int total) {

      cardProvider.updateItem(Item(
        id: item.id,
        coveringMethod: item.coveringMethod,
        productId: item.productId,
        groupValues: item.groupValues,
        savedImage: item.savedImage,
        quantity: value,
        aliveDeliveryForm: item.aliveDeliveryForm,
        options: item.options,
        beafQuantity: item.beafQuantity,
        notes: item.notes,
        totalPrice: total,
        imagePath: item.imagePath,
        title: item.title,
        productPrice: item.productPrice,
        productName: item.productName,
        selectedProductIndex: item.selectedProductIndex,
        cuttingOption: item.cuttingOption,
        maphromeFlag: item.maphromeFlag,
        cuttingType: item.cuttingType,
        selectedCuttingOption: item.selectedCuttingOption,
        selectedProduct: item.selectedProduct,
        categoryID: item.categoryID,
      ));

    }


    return item == null ? SizedBox(height: 0.0,width: 0.0,)
        :Card(
      color: Colors.white,
      elevation: 8.0,
      child:Container(

        height: 300.0,
        width: MediaQuery.of(context).size.width -10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex:2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: Icon(Icons.delete,size: 30.0,color: Colors.redAccent,), onPressed: ()async{
                          await cardProvider.deleteItem(item.id);
                        }),
                        TextWidget(title: "النوع",value: item.title,)
                    ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(height: 5.0,),
                  Expanded(
                    flex: 9,
                    child:Column(
                      children: [
                        ...optionsList.map((e) => TextWidget(title: e["option_name"],value: e["option_value"])),
                      ],
                    ),
                    // GridView.builder(
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //
                    //       crossAxisCount: 2,
                    //       childAspectRatio: 8 / 2,
                    //       crossAxisSpacing: 2.0,
                    //       mainAxisSpacing: 2.0),
                    //   itemCount: optionsList.length,
                    //   itemBuilder: (BuildContext ctx, index) {
                    //     return TextWidget(title: optionsList[index]["option_name"],value: optionsList[index]["option_value"],);
                    //   }),
                  ),
                  Expanded(flex:5,
                      child: QuantityCard(quantity: item.quantity,price: price,updateValue: updateQuantity,)),


                ],
              ),
            ),
            SizedBox(width: 10.0,),
            Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Container(
                          height: 280.0,
                          child: ClipRRect(
                            child: Image.file(File(item.imagePath), fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      // ElevatedButton(
                      //   child: Text("تعديل"),
                      //   onPressed: (){
                      //
                      //     Navigator.of(context).pushNamed(ShowItemOption.routeName,
                      //         arguments: Settings(id: item.categoryID,imageURL: item.imagePath,editingOption: true,title:item.title , item: item));
                      //   },
                      // )
                    ],
                  ),
                ),)

          ],
        ),
      ),
    );
  }
}


