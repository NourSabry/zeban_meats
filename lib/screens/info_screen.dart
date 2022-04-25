import 'package:flutter/material.dart';
import '../providers/order.dart';
import '../providers/orders_provider.dart';
import '../providers/card_provider.dart';
import 'package:provider/provider.dart';
import '../screens/all_products_screen.dart';
import '../helpers/my_flutter_app_icons.dart';

enum Types { CALL, WHATSAPP }
enum Payment { CASH }

class InfoScreen extends StatefulWidget {
  static final routeName = "/info-screen";

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  FocusNode _addressFocusNode;
  FocusNode _phoneFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Types _type;
  Payment _payment;
  Order orderItem;
  String paymentMethod = "";
  String orderConfirmation = "";
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _addressFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    if (orderItem == null) {
      orderItem = ModalRoute.of(context).settings.arguments;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("دنيا"),
      //   actions: [
      //     Card(
      //       child: Container(
      //           // height: 10.0,
      //           width: 100.0,
      //           child: Center(child: Text("0558117341"))),
      //     ),
      //   ],
      // ),

      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _isloading
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 0.5,
              ))
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(5.0),
                  child: Form(
                    key: _formKey,
                    child: Scrollbar(
                      thickness: 8.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "amiri",
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xbb8d2424),
                                  ),
                                  decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    labelText: 'الإسم',
                                    labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "amiri",
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF8d2424),
                                    ),
                                  ),
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        value == null ||
                                        value.length < 3) {
                                      return 'برجاء إدخال الإسم';
                                    }
                                    return null;
                                  },
                                  autofocus: true,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_addressFocusNode);
                                  },
                                  onSaved: (value) {
                                    orderItem = Order(
                                      cart: orderItem.cart,
                                      phone: orderItem.phone,
                                      address: orderItem.address,
                                      paymentMethod: orderItem.paymentMethod,
                                      name: value,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      labelText: 'العنوان',
                                      labelStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "amiri",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF8d2424),
                                      )),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "amiri",
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xbb8d2424),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        value == null ||
                                        value.length < 3) {
                                      return 'برجاء إدخال العنوان';
                                    }
                                    return null;
                                  },
                                  focusNode: _addressFocusNode,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_phoneFocusNode);
                                  },
                                  onSaved: (value) {
                                    orderItem = Order(
                                      cart: orderItem.cart,
                                      phone: orderItem.phone,
                                      address: value,
                                      paymentMethod: orderItem.paymentMethod,
                                      name: orderItem.name,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Card(
                                      child: Container(
                                        height: 60.0,
                                        child: Center(
                                          child: Text(
                                            "00966",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: "amiri",
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF8d2424),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            // border: InputBorder.none,
                                            labelText: 'رقم الجوال',
                                            labelStyle: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: "amiri",
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF8d2424),
                                            )),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "amiri",
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xbb8d2424),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty || value == null) {
                                            return 'برجاء إدخال رقم الجوال';
                                          } else if (value.length != 9) {
                                            return 'برجاء إدخال رقم جوال 9 أرقام';
                                          }
                                          return null;
                                        },
                                        focusNode: _phoneFocusNode,
                                        onSaved: (value) {
                                          if (value != "") {
                                            try {
                                              orderItem = Order(
                                                cart: orderItem.cart,
                                                phone: int.parse(value),
                                                address: orderItem.address,
                                                paymentMethod:
                                                    orderItem.paymentMethod,
                                                name: orderItem.name,
                                              );
                                            } catch (e) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    // Retrieve the text the that user has entered by using the
                                                    // TextEditingController.
                                                    content: Text(
                                                        "برجاء إدخال الأرقام بشكل صحيح"),
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60.0,
                                    width: (MediaQuery.of(context).size.width -
                                            50) *
                                        3 /
                                        4,
                                    child: Card(
                                      child: Center(
                                          child: Text(
                                        "الرياض",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: "lateef",
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF8d2424),
                                        ),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                      height: 60.0,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              4,
                                      child: Center(
                                          child: Text(
                                        "المدينه",
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontFamily: "amiri",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF8d2424),
                                        ),
                                      )))
                                ],
                              ),
                            ),
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "طريقة الدفع",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: "amiri",
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF8d2424),
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Card(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 50.0,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      "دفع نقدا عند الإستلام",
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        fontFamily: "lateef",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF8d2424),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Radio<Payment>(
                                                    // shape: CircleBorder(),
                                                    groupValue: _payment,
                                                    value: Payment.CASH,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _payment = newValue;
                                                        paymentMethod =
                                                            "دفع نقدا عند الإستلام";
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "طريقة تأكيد الطلب",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "amiri",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF8d2424),
                                        ),
                                        textAlign: TextAlign.right,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Card(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 50.0,
                                                  width: 100.0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.phone_android,
                                                        color:
                                                            Colors.greenAccent,
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        "إتصال",
                                                        style: TextStyle(
                                                          fontSize: 25.0,
                                                          fontFamily: "lateef",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xFF8d2424),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Radio<Types>(
                                                  // shape: CircleBorder(),
                                                  groupValue: _type,
                                                  value: Types.CALL,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _type = newValue;
                                                      orderConfirmation =
                                                          "إتصال";
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Card(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 100.0,
                                                  height: 50.0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        MyFlutterApp.whatsapp_1,
                                                        color: Colors.green,
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        "واتساب",
                                                        style: TextStyle(
                                                          fontSize: 25.0,
                                                          fontFamily: "lateef",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xFF8d2424),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Radio<Types>(
                                                  // shape: CircleBorder(),
                                                  groupValue: _type,
                                                  value: Types.WHATSAPP,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _type = newValue;
                                                      orderConfirmation =
                                                          "واتساب";
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                        "المجموع الكلى ${orderItem.cart.totalAmount} ر.س"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      var snackbar;
                                      if (paymentMethod == "" ||
                                          paymentMethod == null) {
                                        snackbar = SnackBar(
                                            content:
                                                Text('يجب إختيار طريقة الدفع'));
                                      } else if (orderConfirmation == "" ||
                                          orderConfirmation == null) {
                                        snackbar = SnackBar(
                                            content: Text(
                                                'يجب إختيار طريقة تأكيد الطلب'));
                                      }
                                      if (!_formKey.currentState.validate()) {
                                        if (snackbar != null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        }
                                      }
                                      if (_formKey.currentState.validate()) {
                                        if (snackbar != null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        } else {
                                          _formKey.currentState.save();
                                          orderItem.orderConfirmation =
                                              orderConfirmation;
                                          orderItem.paymentMethod =
                                              paymentMethod;
                                          setState(() {
                                            _isloading = true;
                                          });

                                          await Provider.of<OrderProvider>(
                                                  context,
                                                  listen: false)
                                              .addOrder(orderItem);
                                          await Provider.of<CardProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteAll();
                                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم إضافه الطلب"),),);
                                          // Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                          // Navigator.pushNamed(context, ProductsScreen.routeName);

                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              ProductsScreen.routeName,
                                              (Route<dynamic> route) => false);
                                        }
                                      }
                                    },
                                    child: Text("إتمام الطلب"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF8d2424),
                                        textStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
