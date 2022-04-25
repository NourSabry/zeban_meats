import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  final Function updateValue;
  final String title;
  final List<String> values;
  int selectedItemIndex;

  MenuButton(
      {this.values, this.updateValue, this.selectedItemIndex, this.title});
  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    if (!widget.values.contains("أختر")) {
      widget.values.insert(0, "أختر");
    }

    return Card(
      color: Color(0xFFFFFFFF),
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "amiri",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFca4153),
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DropdownButton(
              value: widget.values[widget.selectedItemIndex],
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: "amiri",
                fontWeight: FontWeight.w400,
                color: Color(0xFF8d2424),
              ),
              dropdownColor: Colors.white,
              elevation: 10,
              iconEnabledColor: Colors.black,
              isExpanded: true,
              // isDense: true,
              iconSize: 30.0,
              // hint: new Text("أختر"),
              onChanged: (newValue) {
                setState(() {
                  widget.selectedItemIndex = widget.values.indexOf(newValue);
                  widget.updateValue(newValue, widget.selectedItemIndex);
                });
              },
              items: widget.values.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                      child: Text(
                    item,
                    style: TextStyle(fontSize: 18.0),
                  )),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
