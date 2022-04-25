import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:mansour/providers/slider_images.dart';
// import 'package:provider/provider.dart';


class HeighlightSwipper extends StatelessWidget {
  final List<String> images;
  const HeighlightSwipper({
    this.images,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // var images = Provider.of<SliderImages>(context).allImageUrls;

    // final images =[
    //   "https://webmeup.com/upload/blog/lead-image-105.png",
    //   "https://www.w3schools.com/w3css/img_lights.jpg",
    //   "https://blog-fr.orson.io/wp-content/uploads/2017/06/jpeg-ou-png.jpg",
    //   "https://thumbs.dreamstime.com/b/eiffel-tower-bridge-iena-river-seine-paris-france-clouds-over-paris-116029281.jpg"
    // ];
    return
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
         child:Swiper(

          itemBuilder: (BuildContext context, int index) {

            return CachedNetworkImage(
              imageUrl: images[index],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => Image.asset("assets/images/giphy (2).gif"),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          },
          itemCount: images.length,
          viewportFraction: 1,
          scale: 1,

          autoplay:true,
          duration:10,
          // pagination:  SwiperPagination(),
          itemWidth: MediaQuery.of(context).size.width,
          // control: new SwiperControl(),

    ),
       );
  }
}
