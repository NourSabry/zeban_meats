import 'package:flutter/material.dart';
import '../screens/card_screen.dart';
import '../screens/orders_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/aboutus.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 100.0,
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Color(0xFF8d2424).withOpacity(0.05),
                centerTitle: true,
                title: Text(
                  "ذيبان للذبائح",
                  style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: "header",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8d2424)),
                ),
                automaticallyImplyLeading: false,
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: Color(0xFFc4192f),
                  size: 30.0,
                ),
                title: Text(
                  'حقيبة التسوق',
                  style: TextStyle(
                    fontFamily: "amiri",
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFca4153),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).popAndPushNamed(CartScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.assignment_turned_in,
                  color: Color(0xFFc4192f),
                  size: 30.0,
                ),
                title: Text(
                  'طلباتى',
                  style: TextStyle(
                    fontFamily: "amiri",
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFca4153),
                  ),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, OrderScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Color(0xFFc4192f),
                  size: 30.0,
                ),
                title: Text(
                  ' من نحن',
                  style: TextStyle(
                    fontFamily: "amiri",
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Color(0xFFca4153),
                  ),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, About.routeName);
                },
              ),
            ],
          ),
          Positioned(
            bottom: 10.0,
            left: 40.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "تواصل معنا",
                  style: TextStyle(
                      fontFamily: "amiri",
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFb23c4b)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/images/twitter_PNG95259.png",
                            fit: BoxFit.fill,
                          ),
                          iconSize: 50.0,
                          splashColor: Colors.black45,
                          onPressed: () async {
                            await canLaunch(
                                    "https://twitter.com/yr2vllmslzd7ugc?s=11")
                                ? await launch(
                                    "https://twitter.com/yr2vllmslzd7ugc?s=11")
                                : throw 'Could not launch "https://twitter.com/yr2vllmslzd7ugc?s=11"';
                          }),
                      SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                          icon: Image.asset(
                            "assets/images/snapchat.png",
                            fit: BoxFit.fill,
                          ),
                          iconSize: 50.0,
                          splashColor: Colors.black45,
                          onPressed: () async {
                            await canLaunch(
                                    "https://www.snapchat.com/add/d_llzbaih17")
                                ? await launch(
                                    "https://www.snapchat.com/add/d_llzbaih17")
                                : throw 'Could not launch "https://www.snapchat.com/add/d_llzbaih17"';
                          }),
                      SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                          icon: Image.asset(
                            "assets/images/instagram_PNG10.png",
                            fit: BoxFit.fill,
                          ),
                          iconSize: 40.0,
                          splashColor: Colors.black45,
                          onPressed: () async {
                            await canLaunch(
                                    "https://www.instagram.com/d_llzbaih17/?igshid=14y9osua6wsnj")
                                ? await launch(
                                    "https://www.instagram.com/d_llzbaih17/?igshid=14y9osua6wsnj")
                                : throw 'Could not launch "https://www.instagram.com/d_llzbaih17/?igshid=14y9osua6wsnj"';
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
