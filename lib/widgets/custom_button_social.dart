import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'custom_text.dart';

class CustomButttonSocial extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback? onPressedFn;

  const CustomButttonSocial({super.key, required this.text, required this.image, this.onPressedFn});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.grey.shade50),
      child: FlatButton(
        onPressed: onPressedFn,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Container(height: 20,child: Image.asset(image,fit: BoxFit.cover,)),
            SizedBox(
              width: 40,
            ),
            CustomText(
              text: text,
            )
          ],
        ),
      ),
    );
  }
}
