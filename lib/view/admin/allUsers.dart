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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            height: 400,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Color.fromRGBO(131, 217, 226, 1),
                  // Color.fromRGBO(162, 230, 209, 1),
                  Color.fromRGBO(12, 116, 117, 1),
                  Color.fromRGBO(14, 174, 87, 1),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                  child: Text(
                'all Users',
                style: TextStyle(
                    fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
              )),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * .06,
              // one dev to role the all

              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // Color.fromRGBO(131, 217, 226, 1),
                    // Color.fromRGBO(162, 230, 209, 1),
                    Color.fromRGBO(12, 116, 117, 1),
                    Color.fromRGBO(14, 174, 87, 1),
                  ],
                ),
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(height: 30,)))
          ]),
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
                                    backgroundImage:
                                        AssetImage('assets/images/prof.png'),
                                    foregroundImage:
                                        usersData[index].pic != 'default'
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
                    )
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
