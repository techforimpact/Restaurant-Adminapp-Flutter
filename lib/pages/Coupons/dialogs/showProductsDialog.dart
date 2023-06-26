// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/style.dart';
import '../../../models/product.dart';
import '../../../models/style.dart';
import '../../../utils/responsive.dart';
import '../add_coupons_to_products/add_coupon_data_to_products.dart';
class ShowProductsDialog extends StatefulWidget {
  const ShowProductsDialog({
    Key? key,
    required this.discountCouponCode,
    required this.discountTitle,
    required this.couponType,
    required this.couponValue,
  }) : super(key: key);

  final String discountCouponCode;
  final String discountTitle;
  final String couponType;
  final num couponValue;

  @override
  State<ShowProductsDialog> createState() => _ShowProductsDialogState();
}

class _ShowProductsDialogState extends State<ShowProductsDialog> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> streamSnapshots =
        FirebaseFirestore.instance
            .collection('products')
            .where('couponCode', isEqualTo: widget.discountCouponCode)
            .snapshots();
    List<ProductsModel> listOfProducts = [];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: streamSnapshots,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data?.docs.forEach((element) {
              listOfProducts.add(ProductsModel.fromMap(element.data()));
            });

            return Container(
              width: Get.width * 0.4,
              height: Get.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.discountTitle,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                            // fontStyle: FontStyle.normal,
                            color: customThemeColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot<Map<String, dynamic>> data =
                                snapshot.data!.docs.toList()[index];

                            return Container(
                              width: 200,
                              height: 60,
                              child: Row(
                                children: [
                                  Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w500,
                                        // fontStyle: FontStyle.normal,
                                        color: customThemeColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    '${data.data()['name']}',
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      // fontStyle: FontStyle.normal,
                                      color: customThemeColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          // listOfProducts.removeAt(index);

                                          await FirebaseFirestore.instance
                                              .collection('products')
                                              .doc(snapshot.data?.docs[index]
                                                  .id)
                                              .update(
                                            {
                                              'couponStatus': false,
                                              'couponCode': '',
                                              'couponValue': 0,
                                              'couponType': '',
                                            },
                                          ).then((value) {
                                            // listOfProducts.clear();
                                            print('delete product');
                                            setState(() {});
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: customThemeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddCouponDataToProductsPage(
                                    couponCode: widget.discountCouponCode,
                                    couponStatus: true,
                                    couponType: widget.couponType,
                                    couponValue: num.parse(
                                      widget.couponValue.toString(),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            primary: active,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Add Products"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              width: Get.width * 0.4,
              height: Get.height * 0.2,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
