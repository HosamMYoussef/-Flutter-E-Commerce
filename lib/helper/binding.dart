import 'package:myshopp/core/viewmodel/auth_view_model.dart';
import 'package:get/get.dart';
import 'package:myshopp/core/viewmodel/cart_view_model.dart';
import 'package:myshopp/core/viewmodel/checkoutview_model.dart';
import 'package:myshopp/core/viewmodel/home_view_model.dart';
import 'package:myshopp/helper/local_storage_data.dart';

import '../core/viewmodel/control_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => HomeViewModel());

    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => LocalStorageUser());
    Get.lazyPut(() => CheckoutViewModel());
   
  }
}
