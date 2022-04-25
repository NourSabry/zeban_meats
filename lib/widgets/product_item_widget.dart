import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category.dart';
import '../screens/show_item_options.dart';
import '../providers/settings.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    final category = Provider.of<Category>(context,listen: false);

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child:Stack(
          children: [GridTile(
            child: CachedNetworkImage(
              imageUrl: category.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      ),
                ),
              ),
              placeholder: (context, url) => Image.asset("assets/images/giphy (2).gif"),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),



            footer: GridTileBar(

              backgroundColor: Colors.white70,
              leading: IconButton(
                splashColor: Colors.black54,
                color: Color(0xFF8d2424),
                icon: Icon(Icons.add_shopping_cart,size: 30,),
                onPressed: () {

                  Navigator.pushNamed(context,ShowItemOption.routeName,
                      arguments: Settings(id: category.id,imageURL: category.imageUrl,title: category.name ,));

                },
              ),
              title: Center(
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFF8d2424),fontSize: 17.0,fontFamily: "lateef",fontWeight: FontWeight.w600),
                  maxLines: 3,),
              ),

            ),

          ),
          // Positioned(
          //   left: -5.0,
          //   bottom: 0.0,
          //   child: IconButton(
          //     splashColor: Colors.black54,
          //     color: Colors.white,
          //       icon: Icon(Icons.add_shopping_cart,size: 30,),
          //       onPressed: () {
          //
          //       Navigator.pushNamed(context,ShowItemOption.routeName,
          //           arguments: Settings(id: category.id,imageURL: category.imageUrl,title: category.name , editingOption: false,));
          //
          //       },
          //     ),
          // ),
          ]
        ),


      ),
    );

  }
}


