import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  final String text;
  const ExpandedWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandedWidgetState createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {

  late String FirstHalf;
  late String SecondHalf;

  bool flag = true;

  @override
  void initState(){
    super.initState();
  if(widget.text.length>150) {
    FirstHalf = widget.text.substring(0, 0);
    SecondHalf = widget.text.substring(1, widget.text.length);
  }else{
    FirstHalf=widget.text;
    SecondHalf="";

  }
}



  @override
  Widget build(BuildContext context) {
    return Container(
      child:SecondHalf.length==""?Text(
        widget.text
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
             flag? FirstHalf:widget.text
          ),

          InkWell(
            onTap: (){
              setState(() {
                flag = !flag;
              });

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(flag? "အသေးစိတ် ကြည့်မယ်":"",
                  style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Icon(flag? Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,
                ),
              ],
            ),
          ),

        ],
      )
    );
  }
}


class PriceExpandedWidget extends StatefulWidget {
  final String text;
  const PriceExpandedWidget({Key? key, required this.text}) : super(key: key);

  @override
  _PriceExpandedWidgetState createState() => _PriceExpandedWidgetState();
}

class _PriceExpandedWidgetState extends State<PriceExpandedWidget> {

  late String FirstHalf;
  late String SecondHalf;

  bool flag = true;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>150) {
      FirstHalf = widget.text.substring(0, 0);
      SecondHalf = widget.text.substring(1, widget.text.length);
    }else{
      FirstHalf=widget.text;
      SecondHalf="";

    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        child:SecondHalf.length==""?Text(
            widget.text
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                flag? FirstHalf:widget.text
            ),

            InkWell(
              onTap: (){
                setState(() {
                  flag = !flag;
                });

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(flag? '''Price အသေးစိတ် ကြည့်မယ်''':"",
                  ),
                  Icon(flag? Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,
                  ),
                ],
              ),
            ),

          ],
        )
    );
  }
}

