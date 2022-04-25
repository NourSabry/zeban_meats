import 'package:flutter/material.dart';


enum Types{Alive, Cutted}


class CuttingRadioButtons extends StatefulWidget {
  final Function updateValue;

  CuttingRadioButtons({this.updateValue,});
  @override
  _CuttingRadioButtonsState createState() => _CuttingRadioButtonsState();
}

class _CuttingRadioButtonsState extends State<CuttingRadioButtons> {

  Types _type ;



  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("حى",textAlign: TextAlign.center,style: TextStyle(fontSize: 25.0,
                fontFamily: "lateef",
                fontWeight: FontWeight.w500,color: Color(0xFF8d2424),),),
              Radio<Types>(
                // shape: CircleBorder(),
                groupValue: _type ,
                value: Types.Alive,
                onChanged: (newValue){
                  setState(() {
                    _type = newValue;

                    widget.updateValue("حى");
                  });
                },

              ),
            ],
          ),
        ),
        Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("مذبوح",textAlign: TextAlign.center,style: TextStyle(fontSize: 25.0,
                fontFamily: "lateef",
                fontWeight: FontWeight.w500,color: Color(0xFF8d2424),),),
              Radio<Types>(
                // shape: CircleBorder(),
                groupValue: _type ,
                value: Types.Cutted,
                onChanged: (newValue){
                  setState(() {
                    _type = newValue;
                    widget.updateValue("مذبوح");
                  });
                },

              ),
            ],
          ),
        )
      ],
    );
  }
}
