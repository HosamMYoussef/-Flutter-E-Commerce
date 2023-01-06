import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshopp/model/user_model.dart';
import 'package:myshopp/view/admin/Adminhomepage.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/view/control_view.dart';
import 'package:myshopp/view/home_view.dart';

import '../../helper/local_storage_data.dart';
import '../services/firestore_user.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  // FacebookLogin _facebookLogin = FacebookLogin();
  late String email, password, name;

  Rxn<User>? _user = Rxn<User>();
  final LocalStorageUser localStorageUser = Get.find();

  String? get user => _user?.value?.email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user!.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getCurrentUser(_auth.currentUser!.uid);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  // SignIn With Google

  void googleSignInMethod() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication _googleSignInAuthentication =
          await _googleUser!.authentication;
      final _googleAuthCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      await _auth.signInWithCredential(_googleAuthCredential).then((user) {
        saveUser(user);
      });
      Get.offAll(ControlView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // SignIn With EmailAndPassword

  void signInWithEmailAndPassword() async {
    try {
      if (email == 'admin@gmail.com') {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          await FirestoreUser()
              .getUserFromFirestore(value.user!.uid)
              .then((value) {
            setUser(UserModel.fromJson(value.data() as Map<dynamic, dynamic>));
          });
        });
        Get.offAll(Adminhome());
      } else {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          await FirestoreUser()
              .getUserFromFirestore(value.user!.uid)
              .then((value) {
            setUser(UserModel.fromJson(value.data() as Map<dynamic, dynamic>));
          });
        });
        Get.offAll(ControlView());
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar(
        'Error login account',
        e.message.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void CreateAccountWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        saveUser(user);
      });
      Get.offAll(LoginView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveUser(UserCredential userCredential) async {
    // await FirestoreUser().addUserToFirestore(UserModel(
    UserModel _userModel = UserModel(
      userId: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: name == null ? userCredential.user!.displayName! : this.name,
      pic: userCredential.user!.photoURL == null
          ? 'https://firebasestorage.googleapis.com/v0/b/ecommerce-95160.appspot.com/o/prof.png?alt=media&token=1dbe4ea7-4eef-4602-83df-d10f97a2ca2f'
          : userCredential.user!.photoURL! + "?width=400",
    );
    await FirestoreUser().addUserToFirestore(_userModel);
    saveUserLocal(_userModel);
  }

  void saveUserLocal(UserModel userModel) async {
    LocalStorageUser.setUserData(userModel);
  }

  void setUser(UserModel userModel) async {
    await LocalStorageUser.setUserData(userModel);
  }

  void signOut() async {
    try {
      await _auth.signOut();
      await LocalStorageUser.clearUserData();
      // GoogleSignIn().signOut();
      // FirebaseAuth.instance.signOut();
    } catch (error) {
      print(error);
    }

//  SignIn With Facebook

//   void facebookSignInMethod() async {
//     FacebookLoginResult result = await _facebookLogin.logIn(['email']);
//     final accessToken = result.accessToken!.token;
//     if (result.status == FacebookLoginStatus.loggedIn) {
//       final faceCedential = FacebookAuthProvider.credential(accessToken);
//       await _auth.signInWithCredential(faceCedential);
//     }
//   }
  }

  void getCurrentUser(String uid) async {
    await FirestoreUser().getUserFromFirestore(uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map<dynamic, dynamic>));
    });
  }

  
}
