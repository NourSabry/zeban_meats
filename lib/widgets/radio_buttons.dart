import 'package:flutter/material.dart';

class RadioButtons extends StatefulWidget {
  final Function updateValue;
  final Function updateGroupValue;
  String groupValue;
  final Map<String, dynamic> itemValues;
  final String title;
  RadioButtons(
      {this.itemValues,
      this.title,
      this.updateValue,
      this.groupValue,
      this.updateGroupValue});

  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  void _handleRadioValueChanged(String value) {
    setState(() {
      widget.groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> questions = <String>[...widget.itemValues["option_values"]];

    return Card(
      color: Colors.white,
      elevation: 8.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "amiri",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8d2424),
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          ...questions.map((item) {
            return RadioListTile<String>(
              title: Text(
                item,
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "lateef",
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8d2424),
                ),
                textAlign: TextAlign.end,
              ),
              value: item,
              dense: true,
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: widget.groupValue,
              onChanged: (newValue) {
                _handleRadioValueChanged(newValue);

                widget.updateValue({
                  "option_name": widget.itemValues["option_name"],
                  "option_value": newValue,
                });
                widget.updateGroupValue({
                  "option_name": widget.title,
                  "option_value": newValue,
                });
              },
            );
          }).toList()
        ],
      ),
    );
  }
}
//
// children: [
//
// Container(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text("مسلوخ",textAlign: TextAlign.center,),
// Radio<Types>(
// // shape: CircleBorder(),
// groupValue: _type ,
// value: Types.Maslokh,
// onChanged: (newValue){
// setState(() {
// _type = newValue;
// widget.updateValue("مسلوخ");
// });
// },
//
// ),
// ],
// ),
// ),
// Container(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text("مشلوط",textAlign: TextAlign.center,),
// Radio<Types>(
// // shape: CircleBorder(),
// groupValue: _type ,
// value: Types.Mashlot,
// onChanged: (newValue){
// setState(() {
// _type = newValue;
// widget.updateValue("مشلوط");
// });
// },
//
// ),
// ],
// ),
// ),
// Container(
//
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text("بدون",textAlign: TextAlign.center,),
// Radio<Types>(
// // shape: CircleBorder(),
// groupValue: _type ,
// value: Types.Without,
// onChanged: (newValue){
// setState(() {
// _type = newValue;
// widget.updateValue("بدون");
// });
// },
//
// ),
// ],
// ),
// )
// ],