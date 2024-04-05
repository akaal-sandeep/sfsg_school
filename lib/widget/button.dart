import 'package:flutter/material.dart';
import 'package:web_school_manager/utility/common_dimensions.dart';



class MyButton extends StatelessWidget {
  Color color;
  String text;
  IconData ?iconButton;
  double borderRadius;
   MyButton({Key? key,required this.text,required this.borderRadius,required this.color,this.iconButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      child:iconButton!=null?Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconButton,color: Colors.white,),
          SizedBox(width: 10,),
          Text(text,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white
          ),),
        ],
      ): Text(text,style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.white
      ),),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(CommonDimension.buttonRadius),
        boxShadow: [
          BoxShadow(
            color:color.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: .6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
    );
  }
}
