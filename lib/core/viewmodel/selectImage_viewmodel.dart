import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SelectImageViewModel extends GetxController {
  File? imageFile;
  String? picUrl;
  bool _isLoading = false;

  File? _imageFile;
  late String imageURL;

  Future gallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(image!.path));
    String x = await uploadTask.then((res) async {
      return res.ref.getDownloadURL();
    });
    print(x);

    _imageFile = File(image.path);
    imageURL = x;
    update();
  }

  Future camera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(image!.path));
    String x = await uploadTask.then((res) async {
      return res.ref.getDownloadURL();
    });
    print(x);

    _imageFile = File(image.path);
    imageURL = x;
    update();
  }

  uploadImageToFirebase() async {
    String _fileName = basename(imageFile!.path);
    Reference _firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profilePics/$_fileName');
    UploadTask _uploadTask = _firebaseStorageRef.putFile(imageFile!);
    picUrl = await (await _uploadTask).ref.getDownloadURL();
  }
}
