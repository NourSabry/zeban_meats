import 'package:flutter/material.dart';
import 'screens/all_products_screen.dart';
import 'package:provider/provider.dart';
import './providers/category.dart';
import 'package:mansour/providers/products_provider.dart';
import 'screens/show_item_options.dart';
import './providers/card_provider.dart';
import './screens/card_screen.dart';
import './screens/info_screen.dart';
import './screens/orders_screen.dart';
import 'package:flutter/services.dart';
import './providers/orders_provider.dart';
import './screens/order_details_screen.dart';
import './providers/slider_images.dart';
import './screens/aboutus.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white70, // navigation bar color
    // statusBarColor: Colors.pink, // status bar color
    // statusBarBrightness: Brightness.dark,//status bar brigtness
    // statusBarIconBrightness:Brightness.dark , //status barIcon Brightness
    // systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
    // systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Category(),
        ),
        ChangeNotifierProvider(
          create: (_) => CardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SliderImages(),
        ),
      ],
      child: MaterialApp(
        title: 'ذيبان للذبائح',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          unselectedWidgetColor: Color(0xFFca4153),
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          primaryColor: Color(0xFFFFFFFF),
          accentColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsScreen(),
        routes: {
          ShowItemOption.routeName: (context) => ShowItemOption(),
          CartScreen.routeName: (context) => CartScreen(),
          ProductsScreen.routeName: (context) => ProductsScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          InfoScreen.routeName: (context) => InfoScreen(),
          OrderDetails.routeName: (context) => OrderDetails(),
          About.routeName: (context) => About(),
        },
      ),
    );
  }
}
