
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/controller.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import '../../utils/global.dart';
import '../../utils/responsive.dart';
import '../orders/orderDetails.dart';

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


class RestaurentDetailsPage extends StatefulWidget {
  const RestaurentDetailsPage({Key? key, this.restModel}) : super(key: key);
  final DocumentSnapshot? restModel;

  @override
  State<RestaurentDetailsPage> createState() => _RestaurentDetailsPageState();
}

class _RestaurentDetailsPageState extends State<RestaurentDetailsPage> {
  final List<String> _banner = [
    "Sr.",
    "Order ID",
    "Date",
    "Customer ID",
    "Amount",
    "Status Order",
  ];

  int? totalSale = 0;
  int? totalOrder = 0;
  int? totalBites = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
 
 
    QuerySnapshot queryBites = await FirebaseFirestore.instance
        .collection('products')
        .where("restaurant_id", isEqualTo: widget.restModel!.get('id'))
        .get();
    setState(() {
      totalBites = queryBites.docs.length;
    });
    QuerySnapshot queryOrders = await FirebaseFirestore.instance
        .collection('orders')
        .where("restaurant_id", isEqualTo: widget.restModel!.get('id'))
        .get();
    setState(() {
      totalOrder = queryOrders.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                "Restaurent Details",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        height: 400,
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
                          padding: const EdgeInsets.only(left: 20, right: 20),
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
                                height: 60,
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
                                    "${widget.restModel!.get('name')}",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: active),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
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
                                    "${widget.restModel!.get('phone')}",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: active),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
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
                                    "${widget.restModel!.get('website_address')}",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: active),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
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
                                      "${widget.restModel!.get('address')}",
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Column(
                          children: [
                            Container(
                              width: 500,
                              height: 400,
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
                                      height: 60,
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       "Total Sales",
                                    //       style: TextStyle(
                                    //           fontFamily: "Nunito",
                                    //           fontSize: 17,
                                    //           fontWeight: FontWeight.w300,
                                    //           color: Colors.grey),
                                    //     ),
                                    //     Text(
                                    //       "250",
                                    //       style: TextStyle(
                                    //           fontFamily: "Nunito",
                                    //           fontSize: 15,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: active),
                                    //     )
                                    //   ],
                                    // ),
                                    //
                                    // SizedBox(
                                    //   height: 30,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Total Orders",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "${totalOrder}",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Total Bites",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "$totalBites",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: active),
                                        )
                                      ],
                                    ),
                                
                               
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
                height: 30,
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        color: active.withOpacity(.1),
                        blurRadius: 12)
                  ],
                  // border: Border.all(color: lightGrey, width: .5),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Order History",
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: active),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      color: Global.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              _banner.length,
                              (index) => index == 0
                                  ? SizedBox(
                                      width: 50,
                                      child: Text(
                                        _banner[index],
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : Expanded(
                                      child: Center(
                                        child: Text(
                                          _banner[index],
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                            )
                            //
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('orders')
                            .orderBy('date_time', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  'Record not found',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            } else {
                              int? indexPrivate = 0;
                              return Wrap(
                                children: List.generate(
                                    snapshot.data!.docs.length, (index) {
                                  if (snapshot.data!.docs[index]
                                          .get('restaurant_id') ==
                                      widget.restModel!.get('id')) {
                                    indexPrivate = indexPrivate! + 1;
                                    DateTime dt = (snapshot.data!.docs[index]
                                            .get('date_time') as Timestamp)
                                        .toDate();
                                    return InkWell(
                                      onTap: () async {
                                        QuerySnapshot query =
                                            await FirebaseFirestore.instance
                                                .collection('restaurants')
                                                .where("id",
                                                    isEqualTo: snapshot
                                                        .data!.docs[index]
                                                        .get('restaurant_id'))
                                                .get();
                                        QuerySnapshot query1 =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .where("uid",
                                                    isEqualTo: snapshot
                                                        .data!.docs[index]
                                                        .get('uid'))
                                                .get();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    OrderDetailsPage(
                                                      documentSnapshot: snapshot
                                                          .data!.docs[index],
                                                      restDocumentSnapshot:
                                                          query.docs[0],
                                                      userDocumentSnapshot:
                                                          query1.docs[0],
                                                    )));
                                      },
                                      child: SizedBox(
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(children: [
                                            SizedBox(
                                              width: 50,
                                              child: Text(
                                                '${indexPrivate}',
                                                style: const TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      .get('id')
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${dt.toString().substring(0, 10)} - ${dt.toString().substring(11, 16)}',
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      .get('uid')
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "\$${snapshot.data!.docs[index].get('grand_total').toString()}",
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: 75,
                                                  height: 30,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xfff8b250),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                          .get('status')
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    );
                                  } else
                                    return const SizedBox();
                                }),
                              );
                            }
                          } else {
                            return Text(
                              'Record not found',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            );
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),

              // OrderWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
