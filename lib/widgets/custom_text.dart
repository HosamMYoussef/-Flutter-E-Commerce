import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int maxLines;
  final double fontSize;
  final Alignment alignment;
  final  String fontFamily;
  final Color color;
    final FontWeight fontWeight;
      final double? height;

  CustomText(
      {this.text = '',
      this.fontWeight = FontWeight.normal,
      this.fontSize = 16,
      this.color = Colors.black,
      this.maxLines=1,
      this.fontFamily='OpenSans',
          this.height,
      this.alignment = Alignment.topLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          // fontFamily: 'Cairo',
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
                    height: height,
                    fontFamily: fontFamily,

        ),
        maxLines: maxLines,
      ),
    );
  }
}
