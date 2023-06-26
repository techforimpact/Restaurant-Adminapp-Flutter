// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/style.dart';
import '../../controllers/general_controller.dart';
import '../../fcm_controller.dart';
import '../../models/product.dart';
import '../../utils/global.dart';
import '../../utils/responsive.dart';
import 'add_coupons_to_products/add_coupon_data_to_products.dart';
class CouponLogic extends GetxController {
  TextEditingController codeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController minAmountValueController = TextEditingController();
  TextEditingController usageLimitController = TextEditingController(text: "1");

  var items = ['Flat Discount', 'Percentage Discount'];

  String? validity_date = '';

  String dropdownvalue = 'Flat Discount';

  late String valueChoose;

  String? createDate;

  String editCouponCode = '';

  bool couponStatus = false;

  QuerySnapshot? querySnapshot;

  void addCoupon({
    bool isUpdate = false,
    String? docId,
  }) async {
    if (codeController.text.isEmpty ||
        titleController.text.isEmpty ||
        messageController.text.isEmpty ||
        discountController.text.isEmpty ||
        usageLimitController.text.isEmpty ||
        minAmountValueController.text.isEmpty ||
        validity_date!.isEmpty) return;

    showProgress();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm:ss a EEE d MMM yyyy').format(now);

    Map<String, dynamic> body = {
      'title': titleController.value.text,
      'message': messageController.value.text,
      'discount': discountController.text,
      'discountCouponCode': codeController.text,
      'usageLimit': usageLimitController.text,
      //!====================================================================
      'minAmountValue': minAmountValueController.text,
      'create_date': createDate ?? formattedDate,
      'validity_date': validity_date,
      'isValid': true,
      'discountMethod': dropdownvalue,
      'uid': Get.find<GeneralController>().boxStorage.read('uid'),
    };

    if (isUpdate) {
      await FirebaseFirestore.instance
          .collection("coupon")
          .doc(docId)
          .update(body);

//====================================================products coupon edit
      await firebaseFirestore
          .collection('products')
          .where('couponCode', isEqualTo: editCouponCode)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          var docRef = FirebaseFirestore.instance
              .collection('products')
              .doc(element.id);
          docRef.update(
            {
              'couponStatus': true,
              'couponCode': codeController.text,
              'couponValue': num.parse(discountController.text),
              'couponType': dropdownvalue,
            },
          );
        });
      });

      resetController();
    } else {
      await FirebaseFirestore.instance.collection("coupon").doc().set(body);
    }

    sendNotificationCallTopicBase(
        'AllUsers',

        ///topic name
        titleController.text,

        /// title
        messageController.text

        /// body
        );
    getAllCoupons();

    dissmissProgress();
    Get.back();
  }

  void getAllCoupons() async {
    querySnapshot = await firebaseFirestore.collection('coupon').get();
    log('documentSnapshotAllCoupons!.data().toString()');
    log(querySnapshot!.docs.length.toString());
    update();
  }

  void activeDeActive(String id, bool isValid, String couponCode) async {
    showProgress();
    await firebaseFirestore
        .collection('coupon')
        .doc(id)
        .update({'isValid': !isValid});

//====================================================products coupon status changed
    await firebaseFirestore
        .collection('products')
        .where('couponCode', isEqualTo: couponCode)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        var docRef = FirebaseFirestore.instance
            .collection('products')
            .doc(element.id);
        docRef.update(
          {
            'couponStatus': !isValid,
          },
        );
      });
    });

    getAllCoupons();
    dissmissProgress();
  }

  void deleteCoupon(String id, String couponCode) async {
    showProgress();
    await firebaseFirestore.collection('coupon').doc(id).delete();

    //====================================================products coupon delete
    await firebaseFirestore
        .collection('products')
        .where('couponCode', isEqualTo: couponCode)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        var docRef = FirebaseFirestore.instance
            .collection('products')
            .doc(element.id);
        docRef.update(
          {
            'couponStatus': false,
            'couponCode': '',
            'couponValue': 0,
            'couponType': '',
          },
        );
      });
    });

    getAllCoupons();
    dissmissProgress();
  }

  void editCoupon(QueryDocumentSnapshot documentSnapshot, String couponCode,
      bool couponActiveOrNot) async {
    editCouponCode = couponCode;
    couponStatus = couponActiveOrNot;
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    discountController.text = data['discount'];
    codeController.text = data['discountCouponCode'];
    usageLimitController.text = data['usageLimit'];
    dropdownvalue = data['discountMethod'];
    messageController.text = data['message'];
    titleController.text = data['title'];
    minAmountValueController.text = data['minAmountValue'];
    validity_date = data['validity_date'];
    createDate = data['create_date'];
    var isValid = data['isValid'];

    showCouponDialogue(isUpdate: true, docId: documentSnapshot.id);
  }

  //!--------------------------------------------------- For Select Products coupon {
  List<ProductsModel> _selectedProducts = [];
  Stream<QuerySnapshot<Map<String, dynamic>>> queryStream = FirebaseFirestore
      .instance
      .collection('products')
      .where('couponCode', isEqualTo: '')
      .snapshots();

//!--------------------------------------------------- For Select Products coupon }

  void showCouponDialogue({bool isUpdate = false, String? docId}) {
    queryStream = FirebaseFirestore.instance
        .collection('products')
        .where('couponCode', isEqualTo: '')
        .snapshots();
    showDialog(
        barrierDismissible: true,
        context: Get.context!,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: GetBuilder<CouponLogic>(builder: (logic) {
              return Container(
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coupon code',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              // height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Global.deepOrange.withOpacity(0.3),
                                      blurRadius: 8,

                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: ListTile(
                                //SEARCH BAR
                                title: TextField(
                                  controller: logic.codeController,
                                  //SEARCH BAR TYPO
                                  textInputAction: TextInputAction.search,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      // fontStyle: FontStyle.normal,
                                      color: Global.deepOrange,
                                      fontSize: 15,
                                    ),
                                    hintText: "Enter Code..",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Title',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              // height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Global.deepOrange.withOpacity(0.3),
                                      blurRadius: 8,

                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: ListTile(
                                //SEARCH BAR
                                title: TextField(
                                  //SEARCH BAR TYPO
                                  controller: logic.titleController,
                                  textInputAction: TextInputAction.search,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      // fontStyle: FontStyle.normal,
                                      color: Global.deepOrange,
                                      fontSize: 15,
                                    ),
                                    hintText: "Enter Title..",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Message',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              height: 250,
                              width: 300,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Global.deepOrange.withOpacity(0.3),
                                      blurRadius: 8,

                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: ListTile(
                                //SEARCH BAR
                                title: Align(
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    //SEARCH BAR TYPO
                                    controller: logic.messageController,
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w500,
                                        // fontStyle: FontStyle.normal,
                                        color: Global.deepOrange,
                                        fontSize: 15,
                                      ),
                                      hintText: "Message..",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coupon Usage Limit',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              // height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Global.deepOrange.withOpacity(0.3),
                                      blurRadius: 8,

                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: ListTile(
                                title: TextField(
                                  controller: logic.usageLimitController,
                                  textInputAction: TextInputAction.search,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      color: Global.deepOrange,
                                      fontSize: 15,
                                    ),
                                    hintText: "Usage Limit",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
//!=============================================================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Min Amount Value',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              // height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Global.deepOrange.withOpacity(0.3),
                                      blurRadius: 8,

                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: ListTile(
                                title: TextField(
                                  controller: logic.minAmountValueController,
                                  textInputAction: TextInputAction.search,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      color: Global.deepOrange,
                                      fontSize: 15,
                                    ),
                                    hintText: "Minimum Amount Value",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              width: 300,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Global.deepOrange.withOpacity(0.3),
                                    blurRadius: 8,

                                    offset: Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                //SEARCH BAR
                                title: Align(
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    //SEARCH BAR TYPO
                                    controller: logic.discountController,
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w500,
                                        // fontStyle: FontStyle.normal,
                                        color: Global.deepOrange,
                                        fontSize: 15,
                                      ),
                                      hintText: "Discount..",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coupon Discount Method',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 230,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: active.withOpacity(0.2))
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: active)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton(
                                        underline: Container(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        elevation: 0,
                                        value: logic.dropdownvalue,
                                        icon: const Icon(
                                          Icons.arrow_drop_down_circle_outlined,
                                          color: Colors.black45,
                                        ),
                                        onChanged: (String? newValue) {
                                          logic.dropdownvalue = newValue!;
                                          logic.update();
                                        },
                                        items: logic.items.map((String items) {
                                          return DropdownMenuItem(
                                            onTap: () {
                                              logic.dropdownvalue = items;
                                              logic.update();
                                            },
                                            alignment: Alignment.center,
                                            value: items,
                                            child: Text(
                                              items,
                                              style: TextStyle(color: active),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        isUpdate
                            ? SizedBox()
                            : SizedBox(
                                height: 20,
                              ),
//!====================================================select produts
                        isUpdate
                            ? SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Select Products',
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      // fontStyle: FontStyle.normal,
                                      color: Global.deepOrange,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 230,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      active.withOpacity(0.2))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(color: active),
                                          ),
//!================================================================================================== add products coupon data
                                          child: InkWell(
                                            onTap: () {
                                              if (logic.codeController.text
                                                      .isEmpty ||
                                                  logic.usageLimitController
                                                      .text.isEmpty ||
                                                  logic.minAmountValueController
                                                      .text.isEmpty ||
                                                  logic.dropdownvalue.isEmpty ||
                                                  logic.discountController.text
                                                      .isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Please enter missing value'),
                                                  ),
                                                );
                                              } else {
                                                // _showMultiSelect(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return AddCouponDataToProductsPage(
                                                        couponCode: logic
                                                            .codeController
                                                            .text,
                                                        couponStatus: true,
                                                        couponType:
                                                            logic.dropdownvalue,
                                                        couponValue: num.parse(
                                                          logic
                                                              .discountController
                                                              .text,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  'Select...',
                                                  style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w500,
                                                    color: Global.deepOrange,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: DateTimePicker(
                            
                            cursorColor: customThemeColor,
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            decoration:
                                InputDecoration(focusColor: customThemeColor,fillColor: Global.deepOrange,prefixIconColor: Global.deepOrange,suffixIconColor: Global.deepOrange),
                            lastDate: DateTime(2100),
                            icon: Icon(
                              Icons.event,
                              color: customThemeColor,
                            ),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            selectableDayPredicate: (date) {
                              // Disable weekend days to select from the calendar
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }

                              return true;
                            },
                            onChanged: (validityDate) {
                              print(validityDate.runtimeType);
                              logic.validity_date = validityDate;
                            },
                            // validator: (validity_date) {
                            //   logic.validity_date=validity_date;
                            //
                            //   return null;
                            // },
                            onSaved: (validityDate) {
                              print(validityDate.runtimeType);
                              logic.validity_date = validityDate;
                            },
                          ),
                        ),
                        isUpdate
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Old Validity Date: $validity_date",
                                  style: TextStyle(
                                      color: customThemeColor, fontSize: 18),
                                ),
                              )
                            : Container(),

                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Validity Date',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                                // fontStyle: FontStyle.normal,
                                color: Global.deepOrange,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Validity Time',
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w500,
                                  // fontStyle: FontStyle.normal,
                                  color: Global.deepOrange,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //----------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    addCoupon(isUpdate: isUpdate, docId: docId);
                                  
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: active,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      isUpdate ? 'UPDATE' : 'SEND',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }

  void resetController() async {
    discountController.text = '';
    codeController.text = '';
    messageController.text = '';
    titleController.text = '';
    usageLimitController.text = '1';
    validity_date = '';
    createDate = '';
    minAmountValueController.text = '';
  }
}
