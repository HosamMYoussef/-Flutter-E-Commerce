import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/model/user_model.dart';

import '../../core/viewmodel/home_view_model.dart';
import '../../helper/local_storage_data.dart';
import '../../widgets/custom_text.dart';
import 'addUser.dart';

class Allusers extends StatefulWidget {
  const Allusers({Key? key}) : super(key: key);

  @override
  State<Allusers> createState() => _AllusersState();
}

class _AllusersState extends State<Allusers> {
  @override
  Widget build(BuildContext context) {
    // Get.put(ProfileViewModel());
    Get.put(LocalStorageUser());
// one dev to role the all

    List<UserModel> usersData = Get.find<HomeViewModel>().users.toList();
    usersData.removeWhere((element) => element.name == 'admin');

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'all Users',
                    fontFamily: 'Baumans',
                    fontSize: 24,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, index) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Get.to(ProductDetailView(id: productsdata[index].productId));
                    },
                    child: ListTile(
                      title: Text(usersData[index].name),
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/prof.png'),
                          foregroundImage: usersData[index].pic != 'default'
                              ? NetworkImage(usersData[index].pic)
                              : null),
                      trailing: Text(usersData[index].email),
                    ),
                  ),
                  const Divider()
                ],
              ),
              itemCount: usersData.length,
            ),
          ),
          // Text(productsdata[0].name),
          // Text(productsdata[1].name)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddUser());
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
