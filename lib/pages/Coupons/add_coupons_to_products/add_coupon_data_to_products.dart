import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../models/product.dart';
import '../../../utils/global.dart';

class AddCouponDataToProductsPage extends StatefulWidget {
  const AddCouponDataToProductsPage(
      {Key? key,
      required this.couponCode,
      required this.couponStatus,
      required this.couponType,
      required this.couponValue})
      : super(key: key);

  final String couponCode;
  final bool couponStatus;
  final String couponType;
  final num couponValue;

  @override
  State<AddCouponDataToProductsPage> createState() => _MultiSelectItemssState();
}

class _MultiSelectItemssState extends State<AddCouponDataToProductsPage> {
  List<ProductsModel> _selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> queryStream = FirebaseFirestore
        .instance
        .collection('products')
        .where('couponCode', isEqualTo: '')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Products'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: queryStream,
        builder: (context, snapshot) {
          List<ProductsModel> multiSelectItemList = [];
          if (snapshot.hasData) {
            snapshot.data?.docs.forEach((element) {
              multiSelectItemList.add(ProductsModel.fromMap(element.data()));
            });

            final _items = multiSelectItemList
                .map((animal) =>
                    MultiSelectItem<ProductsModel>(animal, animal.name))
                .toList();

            return Container(
              padding: const EdgeInsets.all(32),
              width: Get.width,
              height: Get.height,
              child: MultiSelectDialogField<ProductsModel>(
                items: _items,
                dialogWidth: Get.width * 0.5,
                title: const Text("Products"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: const BorderRadius.all( Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon:  Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Global.deepOrange,
                ),
                searchable: true,
                buttonText: Text(
                  "Select Products For Add Coupons",
                  style: TextStyle(
                    color: Global.deepOrange,
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  _selectedProducts = results;

                  if (_selectedProducts.isNotEmpty) {
                    _selectedProducts.forEach(
                      (element1) async {
                    print('selected product id ${element1.id}');

                        await FirebaseFirestore.instance
                            .collection('products')
                            .get()
                            .then(
                              (value) => value.docs.forEach(
                                (element) {
                    print('other product ${element.get('id')}');

                                  if (element1.id == element.get('id')) {
                                    log('111111111111111111111111111111111111111111111111111111111');
                                    var docRef = FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(element.id);

                                    docRef.update(
                                      {
                                        'couponStatus': widget.couponStatus,
                                        'couponCode': widget.couponCode,
                                        'couponValue': widget.couponValue,
                                        'couponType': widget.couponType,
                                      },
                                    );
                                  }
                                },
                              ),
                            );
                      },
                    );
                  }

                  log('ok ho gya =============================>');
                  Navigator.pop(context);
                },
              ),
            );
          } else {
            return const Center(
              child:  CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
