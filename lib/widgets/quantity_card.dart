import 'package:flutter/material.dart';

class QuantityCard extends StatefulWidget {
  int quantity;
  int price;
  final Function updateValue;
  QuantityCard({this.quantity, this.updateValue, this.price});
  @override
  _QuantityCardState createState() => _QuantityCardState();
}

class _QuantityCardState extends State<QuantityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                child: Icon(
                  Icons.add,
                  size: 20.0,
                  color: Colors.white,
                ),
                color: Color.fromARGB(136, 226, 174, 174),
                shape: CircleBorder(),
                minWidth: 20.0,
                elevation: 8.0,
                onPressed: () {
                  setState(() {
                    widget.quantity++;
                  });
                  widget.updateValue(
                      widget.quantity, widget.quantity * widget.price);
                },
              ),
              Container(
                child: Center(
                  child: Text(
                    widget.quantity.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFca4153),
                      // color: Colors.white70,
                    ),
                  ),
                ),
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 3,
              ),
              MaterialButton(
                child: Icon(
                  Icons.remove,
                  size: 25.0,
                  color: Colors.white,
                ),
                color: Color.fromARGB(136, 226, 174, 174),
                shape: CircleBorder(),
                minWidth: 20.0,
                elevation: 8.0,
                onPressed: () {
                  setState(() {
                    widget.quantity <= 1
                        ? widget.quantity = 1
                        : widget.quantity--;
                  });
                  widget.updateValue(
                      widget.quantity, widget.quantity * widget.price);
                },
              ),
            ],
          ),
          Text(
            "السعر الإجمالى ${widget.price * widget.quantity} ر.س ",
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "lateef",
              fontWeight: FontWeight.w600, color: Color(0xFFca4153),
              // color: Colors.white70
            ),
          ),
        ],
      ),
    );
  }
}
