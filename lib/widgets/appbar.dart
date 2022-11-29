// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// import '../view/search_view.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     Key? key,
//     this.title = '',
//     this.leading,
//     this.titleWidget,
//   }) : super(key: key);
//   final String title;
//   final Widget? leading;
//   final Widget? titleWidget;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: IconButton(
//             icon: Icon(
//               Icons.arrow_back_sharp,
//               size: 30,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ),
//         flexibleSpace: Container(
//           // height: 400,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color.fromRGBO(131, 217, 226, 1),
//                 Color.fromRGBO(162, 230, 209, 1),
//               ],
//             ),
//           ),
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(top: 26, left: 50, right: 16, bottom: 3),
//             child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 elevation: 4,
//                 child: _searchTextFormField()),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(
//         80,
//       );
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../view/search_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(100),
      //     bottomRight: Radius.circular(40),
      //   ),
      // ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      flexibleSpace: Container(
        // height: 400,
        decoration: const BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(30),
            //   bottomRight: Radius.circular(30),
            // ),
          
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(131, 217, 226, 1),
              Color.fromRGBO(162, 230, 209, 1),
            ],
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 26, left: 50, right: 16, bottom: 3),
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
