
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/controller.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import '../../utils/responsive.dart';
import '../customers/widgets/customerDetails.dart';
import '../restaurent/restaurentDetails.dart';

class Status {
  String name;
  String orderid;
  String date;
  String price;
  String customer;
  Color color;
  Status(
      {required this.name,
      required this.color,
      required this.orderid,
      required this.date,
      required this.price,
      required this.customer});
}

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage(
      {Key? key,
      this.documentSnapshot,
      this.restDocumentSnapshot,
      this.userDocumentSnapshot})
      : super(key: key);

  final DocumentSnapshot? documentSnapshot;
  final DocumentSnapshot? restDocumentSnapshot;
  final DocumentSnapshot? userDocumentSnapshot;
  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  @override
  Widget build(BuildContext context) {
    DateTime dt =
        (widget.documentSnapshot!.get('date_time') as Timestamp).toDate();
   
    return Column(
      children: [
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 40,
                  ),
                  child: Text(
                    menuController.activeItem.value,
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: active),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: customThemeColor),
                      child: const Center(
                        child: Text(
                          'Back',
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: ResponsiveWidget.isSmallScreen(context) ? 56 : 40,
              ),
              child: Text(
                "Order Details",
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: active),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Container(
                          width: 500,
                          // height: 590,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: active.withOpacity(.4), width: .5),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 6),
                                  color: active.withOpacity(.1),
                                  blurRadius: 12)
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Wrap(
                                children: List.generate(
                                    widget.documentSnapshot!
                                        .get('product_list')
                                        .length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 450,
                                      // height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 6),
                                              color: active.withOpacity(.1),
                                              blurRadius: 4)
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: const BoxDecoration(
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image.network(
                                                  '${widget.documentSnapshot!.get('product_list')[index]['image']}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '${widget.documentSnapshot!.get('product_list')[index]['name']}',
                                                  style: const TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  '${dt.toString()}',
                                                  style: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[200]),
                                                ),
                                                Text(
                                                  '${widget.documentSnapshot!.get('restaurant')}',
                                                  style: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[200]),
                                                )
                                              ],
                                            ),
                                            Text(
                                              'Rs${widget.documentSnapshot!.get('product_list')[index]['dis_price'].toString()}',
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: active),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            RestaurentDetailsPage(
                                              restModel:
                                                  widget.restDocumentSnapshot,
                                            )));
                              },
                              child: Container(
                                width: 500,
                                // height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: active.withOpacity(.4), width: .5),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 6),
                                        color: active.withOpacity(.1),
                                        blurRadius: 12)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(
                                          'Restaurent',
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Name",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey),
                                          ),
                                          SelectableText(
                                            '${widget.documentSnapshot!.get('restaurant')}',
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: active),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Phone No.",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey),
                                          ),
                                          SelectableText(
                                            '${widget.restDocumentSnapshot!.get('phone')}',
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: active),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Website",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey),
                                          ),
                                          SelectableText(
                                            '${widget.restDocumentSnapshot!.get('website_address')}',
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: active),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Address",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey),
                                          ),
                                          Expanded(
                                            child: SelectableText(
                                              '${widget.restDocumentSnapshot!.get('address')}',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: active),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            CustomerDetailsPage(
                                              userModel:
                                                  widget.userDocumentSnapshot,
                                            )));
                              },
                              child: Container(
                                width: 500,
                                // height: 230,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: active.withOpacity(.4), width: .5),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 6),
                                        color: active.withOpacity(.1),
                                        blurRadius: 12)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(
                                          'Customer',
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Name",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey),
                                          ),
                                          SelectableText(
                                            "${widget.userDocumentSnapshot!.get('name')}",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: active),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Phone No.",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey),
                                          ),
                                          SelectableText(
                                            "${widget.userDocumentSnapshot!.get('phone')}",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: active),
                                          )
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      //
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text("Address",
                                      //       style: TextStyle(
                                      //           fontFamily: "Nunito",
                                      //           fontSize: 17,
                                      //           fontWeight: FontWeight.w300,
                                      //           color: Colors.grey
                                      //       ),
                                      //
                                      //     ),
                                      //     Text("5 Lancaster St.Eastlake",
                                      //       style: TextStyle(
                                      //           fontFamily: "Nunito",
                                      //           fontSize: 15,
                                      //           fontWeight: FontWeight.bold,
                                      //           color: active
                                      //       ),
                                      //
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 500,
                              // height: 230,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: active.withOpacity(.4), width: .5),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 6),
                                      color: active.withOpacity(.1),
                                      blurRadius: 12)
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        'Take Away',
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: active),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Is ItTake Away?",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        SelectableText(
                                          widget.documentSnapshot!
                                                      .get('isTakeAway')
                                                      .toString() ==
                                                  'true'
                                              ? "Yes"
                                              : "No",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 500,
                              // height: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: active.withOpacity(.4), width: .5),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 6),
                                      color: active.withOpacity(.1),
                                      blurRadius: 12)
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        "Summary",
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: active),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Total Price",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Rs${widget.documentSnapshot!.get('total_price')}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Product Discount",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "${widget.documentSnapshot!.get('total_discount_percentage')}%",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Coupon Discount",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Rs${widget.documentSnapshot!.get('coupon_discount')}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Gross Total",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Rs${widget.documentSnapshot!.get('net_price') - double.parse(widget.documentSnapshot!.get('coupon_discount').toString())}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Commission",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "${widget.restDocumentSnapshot!.get('commission').toString()}%",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Net Price",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Rs${widget.documentSnapshot!.get('net_price') - ((int.parse(widget.restDocumentSnapshot!.get('commission').toString()) ~/ 100))}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // SizedBox(
                                    //   height: 100,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    //     SizedBox(
                                    //       height: 60,
                                    //       // width: 120,
                                    //       child: ElevatedButton(
                                    //           onPressed: (){
                                    //             },
                                    //           style: ElevatedButton.styleFrom(
                                    //               primary: active,
                                    //               shape: RoundedRectangleBorder(
                                    //                 borderRadius: BorderRadius.circular(30.0),
                                    //
                                    //               )
                                    //           ),
                                    //           child:Align(
                                    //             alignment: Alignment.center,
                                    //             child: Text(
                                    //               'Order Processed',
                                    //               style: TextStyle(
                                    //                 color: Colors.white,
                                    //               ),
                                    //             ),
                                    //           )
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(
                height: 40,
              ),

              // OrderWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
