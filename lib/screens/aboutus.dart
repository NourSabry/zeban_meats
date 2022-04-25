import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static final routeName = "/about-us";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "من نحن",
          style: TextStyle(
              fontSize: 28.0,
              fontFamily: "header",
              fontWeight: FontWeight.w900,
              color: Color(0xFF915f3a)),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Color(0xFFca4153)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 8.0,
                    color: Color.fromARGB(255, 245, 245, 245),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "نعمل فى بيع وذبح وتغليف وتوصيل أفضل الأغنام البلدى"
                          " بسيارارت مبرده على مدار العام"
                          " بجميع مناطق الرياض"
                          " وتتميز منتجاتنا بالجودة العالية"
                          " والأسعار المناسبة (نعيمي، هرفي، حري)",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: "header",
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8d2424)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 30),
                        Card(
                            elevation: 8.0,
                            color: Color.fromARGB(255, 245, 245, 245),
                            child: Text(
                              "رقم الهاتف ",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "header",
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8d2424),
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Card(
                          elevation: 8.0,
                          color: Color.fromARGB(255, 245, 245, 245),
                          child: Text(
                            "00966581606724",
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "header",
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8d2424)),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
