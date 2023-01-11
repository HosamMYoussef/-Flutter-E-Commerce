// // import 'dart:developer';
// // import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:my_fatoorah/my_fatoorah.dart';
// import 'package:myshopp/constants.dart';
// import 'package:path/path.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// import 'dart:async';
// // import 'package:flutter_tap_payment/flutter_tap_payment.dart';
// import '../core/viewmodel/home_view_model.dart';
// import '../model/product_model.dart';
// import '../widgets/ListViewPage.dart';
// import '../widgets/speach.dart';
// import '../widgets/timer.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite/tflite.dart';

// class Timers extends StatefulWidget {
//   const Timers({Key? key}) : super(key: key);

//   @override
//   State<Timers> createState() => _TimersState();
// }

// class _TimersState extends State<Timers> {
//   stt.SpeechToText? _speech;
//   bool _isListening = false;
//   double _confidence = 1.0;
//   List ?_outputs;
//   var _image;
//   bool  _loading = false;

//   String _text = 'Press the button and start speaking';
//   @override
//   void initState(){
//       super.initState();
//       _loading = true ;

//       loadModel().then((value) {
//         setState(() {
//           _loading = false;
//   });
//   });
//   }
//   String text = 'Press the button and start speaking';
//   bool isListening = false;
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Classification'),

//       ),
//       body: _loading
//         ? Container(
//         alignment: Alignment.center,
//         child: CircularProgressIndicator(),
//       )
//           : Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image == null ? Container() : Image.file(_image),
//             SizedBox(
//               height: 20,
//             ),
//             _outputs != null
//               ? Text(
//               "${_outputs![0]["label"]}",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20.0 ,
//                 background: Paint()..color = Colors.white,
//               ),
//             )
//                 : Container()
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         child: Icon(Icons.start),
//       ),
//     );
//   }
//   pickImage() async {
//     var image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image == null) return null;
//     setState(() {
//       _loading = true ;
//       _image = image;

//     });
//     classifyImage(image);
//   }
//   classifyImage(XFile image) async{
//     var output = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 2,
//       threshold: 0.5,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     setState(() {
//       _loading = false ;
//       _outputs = output;
//     });
//   }
//   loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/assets/model_unquant.tflite",
//       labels: "assets/assets/labels.txt",
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../core/viewmodel/home_view_model.dart';
import '../model/auction_model.dart';
import '../model/product_model.dart';
import 'home_view.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List? _outputs;
  File ?_image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
         customErrorScreen();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    List<AuctionModel> auctions = Get.find<HomeViewModel>().auctions.toList();

    return Scaffold(
       appBar: AppBar(
        title: const Text('Machine Learning'),
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null ? Container() : Image.file(_image!),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null
                      ? Text(
                          "${_outputs![0]["label"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            background: Paint()..color = Colors.white,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.image),
      ),
    );
  }
   pickImage() async {
        final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      // _image = image;
    });
    classifyImage(image);
  }
   classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 1,
      threshold: 0.1,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
