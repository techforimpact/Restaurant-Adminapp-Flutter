// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/style.dart';
import '../../utils/global.dart';
import '../../utils/responsive.dart';
import 'coupon_get.dart';
import 'dialogs/showProductsDialog.dart';

/// Example without datasource
class CouponTable extends StatefulWidget {
  const CouponTable({Key? key}) : super(key: key);

  @override
  State<CouponTable> createState() => _CouponTableState();
}

class _CouponTableState extends State<CouponTable>
    with SingleTickerProviderStateMixin {
  final CouponLogic logisc = Get.put(CouponLogic());

  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    logisc.getAllCoupons();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final List<String> _banner = [
    "Sr.",
    "Name",
    "Validity",
    "Method",
    "Code",
    "Discounted",
    "Status",
    "Edit",
    "Delete",
    "Usage Limit",
    "Min Amount",
    "Products",
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponLogic>(
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: active.withOpacity(.4), width: .5),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 600,
                  // width: 550,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Active Coupon',
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black45),
                          ),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {
                                  logic.resetController();
                                  logic.showCouponDialogue();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: active,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    )),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Add Coupon',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Global.deepOrange,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                _banner.length,
                                (index) => index == 0
                                    ? SizedBox(
                                        width: 50,
                                        child: Text(
                                          _banner[index],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : Expanded(
                                        child: Center(
                                          child: Text(
                                            _banner[index],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                              )
                              //
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      logic.querySnapshot != null
                          ? Expanded(
                              child: Column(
                                children: List.generate(
                                    logic.querySnapshot!.docs.length, (index) {
                                  Map<String, dynamic> data =
                                      logic.querySnapshot!.docs[index].data()
                                          as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      height: 70,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            child: Text(
                                              '${index + 1}',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${data['title']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "${data['validity_date']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "${data['discountMethod']}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${data['discountCouponCode']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${data['discount']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          //!========================================================= coupon status code here
                                          Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    logic.querySnapshot!
                                                        .docs[index].id;
                                                    logic.activeDeActive(
                                                      logic.querySnapshot!
                                                          .docs[index].id,
                                                      data['isValid'],
                                                      data[
                                                          'discountCouponCode'],
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    // primary: active
                                                    primary: data['isValid']
                                                        ? active
                                                        : Colors.black38,
                                                  ),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,

                                                      // child: isSelected
                                                      child: data['isValid']
                                                          ? Text("Active")
                                                          : Text("Inactive"))),
                                            ),
                                          ),

                                          //!========================================================= coupon edit here
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              logic.editCoupon(
                                                  logic.querySnapshot!
                                                      .docs[index],
                                                  data['discountCouponCode'],
                                                  data['isValid']);
                                            },
                                            child: Center(
                                                child: Icon(
                                              Icons.update,
                                              color: customThemeColor,
                                            )),
                                          )),
                                          //!========================================================= coupon delete here
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              logic.deleteCoupon(
                                                  logic.querySnapshot!
                                                      .docs[index].id,
                                                  data['discountCouponCode']);
                                            },
                                            child: Center(
                                                child: Icon(
                                              Icons.delete,
                                              color: customThemeColor,
                                            )),
                                          )),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${data['usageLimit']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${data['minAmountValue']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),

                                          //!========================================================= coupon status code here
                                          Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                    barrierDismissible: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return ShowProductsDialog(
                                                        discountCouponCode: data[
                                                            'discountCouponCode'],
                                                        discountTitle:
                                                            data['title'],
                                                        couponType: data[
                                                            'discountMethod'],
                                                        couponValue: num.parse(
                                                            data['discount']),
                                                      );
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                  // primary: active
                                                  primary: active,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,

                                                  // child: isSelected
                                                  child: Text("Products"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
