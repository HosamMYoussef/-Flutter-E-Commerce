import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../view/search_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(55.0),
        super(key: key);
  @override
  final Size preferredSize;
// one dev to role the all

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // leading: Padding(
      //   padding: const EdgeInsets.only(top: 0.0),
      //   child: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_sharp,
      //       size: 25,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ),
      flexibleSpace: Container(
        height: 110,
        // height: 400,
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(35),
          //   bottomRight: Radius.circular(35),
          // ),

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Color.fromRGBO(131, 217, 226, 1),
              // Color.fromRGBO(162, 230, 209, 1),


              //  Color.fromRGBO(51, 139, 147, 1),
                // Color.fromRGBO(182, 244, 146, 1),


               Color.fromRGBO(12,116,117,1),
               Color.fromRGBO(14,174,87,1),
            ],
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 50, right: 16, bottom: 3),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: _searchTextFormField()),
        ),
      ),
    );
  }
}

Widget _searchTextFormField() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: TextFormField(
      decoration: const InputDecoration(
        hintText: "Search Shopify",
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black54,
        ),
      ),
      onFieldSubmitted: (value) {
        Get.to(SearchView(value));
      },
    ),
  );
}
