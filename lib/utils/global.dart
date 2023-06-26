import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Global {
  static Color deepOrange = const Color(0XFFc4de8c);
  static Color colorSecond = Colors.white;
  static Color color = const Color(0xffF5F5F8);
}

showProgress(){

  Get.dialog(Center(child: CircularProgressIndicator(color: Global.deepOrange,),));

}

dissmissProgress(){
  if(Get.isDialogOpen!){
    Get.back();
  }
}
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;