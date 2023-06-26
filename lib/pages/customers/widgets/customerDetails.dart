
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/controller.dart';
import '../../../constants/style.dart';
import '../../../helpers/responsiveness.dart';
import '../../../utils/global.dart';
import '../../../utils/responsive.dart';
import '../../orders/orderDetails.dart';

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

List<String> _buttonNames = [
  "All Status",
  "New Order",
  "On Progress",
  "Delivered"
];
List<String> _pageNo = ["1", "2", "3", "4"];
int _currentSelectedButton = 0;
int _currentSelectedButton1 = 1;

class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({Key? key, this.userModel}) : super(key: key);

  final DocumentSnapshot? userModel;
  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  List<String> _banner = [
    "Sr.",
    "Order ID",
    "Date",
    "Customer ID",
    "Amount",
    "Status Order",
  ];

  List<Status> _status = [
    Status(
        name: "+919191919191",
        color: const Color(0xfff8b250),
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$164.52"),
    Status(
        name: "+919191919191",
        color: const Color(0xff13d38e),
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$74.92"),
    Status(
        name: "+919191919191",
        color: Colors.grey,
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$251.16"),
    Status(
        name: "+919191919191",
        color: const Color(0xfff8b250),
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$82.46"),
    Status(
        name: "+919191919191",
        color: const Color(0xff13d38e),
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$24.17"),
    Status(
        name: "+919191919191",
        color: const Color(0xfff8b250),
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$24.55"),
    Status(
        name: "+919191919191",
        color: Colors.grey,
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Samantha Bake",
        price: "\$22.18"),
    Status(
        name: "+919191919191",
        color: Colors.grey,
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$45.86"),
    Status(
        name: "+919191919191",
        color: const Color(0xff13d38e),
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$34.41"),
    Status(
        name: "+919191919191",
        color: const Color(0xff13d38e),
        orderid: "04-01-2022",
        date: "xyz@gmail.com",
        customer: "Grill Hub",
        price: "\$44.99"),
  ];

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
                "Customer Details",
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: active),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
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
                          padding: const EdgeInsets.only(left: 20, right: 20),
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

                              widget.userModel!.get('image').toString() == ''
                                  ? const SizedBox()
                                  : Container(
                                      height: 80,
                                      width: 80,
                                      decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                          '${widget.userModel!.get('image')}',
                                          fit: BoxFit.cover,
                                        ),
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
                                    "${widget.userModel!.get('name')}",
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
                                    "Email",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                  ),
                                  SelectableText(
                                    "${widget.userModel!.get('email')}",
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
                                    "${widget.userModel!.get('phone')}",
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

                      // Padding(
                      //   padding: const EdgeInsets.only(right: 30),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         width: 500,
                      //         height: 400,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           // border: Border.all(color: active.withOpacity(.4), width: .5),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 offset: Offset(0, 6),
                      //                 color: active.withOpacity(.1),
                      //                 blurRadius: 12)
                      //           ],
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(right: 20, left: 20),
                      //           child: Column(
                      //             children: [
                      //               SizedBox(
                      //                 height: 20,
                      //               ),
                      //               Center(
                      //                 child: Text(
                      //                   "Summary",
                      //                   style: TextStyle(
                      //                       fontFamily: "Nunito",
                      //                       fontSize: 24,
                      //                       fontWeight: FontWeight.bold,
                      //                       color: active
                      //                   ),
                      //
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 60,
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Text("Total Price",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 17,
                      //                         fontWeight: FontWeight.w300,
                      //                         color: Colors.grey
                      //                     ),
                      //
                      //                   ),
                      //                   Text("\$100",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 15,
                      //                         fontWeight: FontWeight.bold,
                      //                         color: active
                      //                     ),
                      //
                      //                   )
                      //                 ],
                      //               ),
                      //
                      //               SizedBox(
                      //                 height: 30,
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Text("Total Savings",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 17,
                      //                         fontWeight: FontWeight.w300,
                      //                         color: Colors.grey
                      //                     ),
                      //
                      //                   ),
                      //                   Text("\$20",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 15,
                      //                         fontWeight: FontWeight.bold,
                      //                         color: active
                      //                     ),
                      //
                      //                   )
                      //                 ],
                      //               ),
                      //
                      //               SizedBox(
                      //                 height: 30,
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Text("Total Net Price",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 17,
                      //                         fontWeight: FontWeight.w300,
                      //                         color: Colors.grey
                      //                     ),
                      //
                      //                   ),
                      //                   Text("\$80",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 15,
                      //                         fontWeight: FontWeight.bold,
                      //                         color: active
                      //                     ),
                      //
                      //                   )
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 30,
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Text("Zero Hero Rank",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 17,
                      //                         fontWeight: FontWeight.w300,
                      //                         color: Colors.grey
                      //                     ),
                      //
                      //                   ),
                      //                   Text("95",
                      //                     style: TextStyle(
                      //                         fontFamily: "Nunito",
                      //                         fontSize: 15,
                      //                         fontWeight: FontWeight.bold,
                      //                         color: active
                      //                     ),
                      //
                      //                   )
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 100,
                      //               ),
                      //               // Row(
                      //               //   mainAxisAlignment: MainAxisAlignment.end,
                      //               //   children: [
                      //               //     SizedBox(
                      //               //       height: 60,
                      //               //       // width: 120,
                      //               //       child: ElevatedButton(
                      //               //           onPressed: (){
                      //               //           },
                      //               //           style: ElevatedButton.styleFrom(
                      //               //               primary: active,
                      //               //               shape: RoundedRectangleBorder(
                      //               //                 borderRadius: BorderRadius.circular(30.0),
                      //               //
                      //               //               )
                      //               //           ),
                      //               //           child:Align(
                      //               //             alignment: Alignment.center,
                      //               //             child: Text(
                      //               //               'Order Processed',
                      //               //               style: TextStyle(
                      //               //                 color: Colors.white,
                      //               //               ),
                      //               //             ),
                      //               //           )
                      //               //       ),
                      //               //     ),
                      //               //   ],
                      //               // )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: active.withOpacity(.4), width: .5),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        color: active.withOpacity(.1),
                        blurRadius: 12)
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "Order History",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: active),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
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
                              return Wrap(
                                children: List.generate(
                                    snapshot.data!.docs.length, (index) {
                                  if (snapshot.data!.docs[index].get('uid') ==
                                      widget.userModel!.get('uid')) {
                                    DateTime dt = (snapshot.data!.docs[index]
                                            .get('date_time') as Timestamp)
                                        .toDate();
                                    return InkWell(
                                      hoverColor: Colors.transparent,
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
                                                '${index + 1}',
                                                style: const TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
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
                                              child: Center(
                                                child: Text(
                                                  '${dt.toString().substring(0, 10)} - ${dt.toString().substring(11, 16)}',
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      .get('uid')
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "\$${snapshot.data!.docs[index].get('net_price').toString()}",
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
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
                    // Card(
                    //   color: Colors.white,
                    //   elevation: 3,
                    //   child: Column(
                    //     children: List.generate(
                    //       _status.length,
                    //       (index) => InkWell(
                    //         onTap: () {
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (builder) =>
                    //                       CustomerDetailsPage()));
                    //         },
                    //         child: ListTile(
                    //           leading: Padding(
                    //             padding: const EdgeInsets.only(left: 100),
                    //             child: Text(
                    //               _status[index].orderid,
                    //               style: TextStyle(color: Colors.black54),
                    //             ),
                    //           ),
                    //           title: Center(
                    //             child: Text(
                    //               _status[index].customer,
                    //               style: TextStyle(color: Colors.black54),
                    //             ),
                    //           ),
                    //           // Row(
                    //           //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           //   children: [
                    //           //
                    //           //     Text(
                    //           //       _status[index].customer,
                    //           //       style: TextStyle(color: Colors.black54),
                    //           //     ),
                    //           //     // Text(
                    //           //     //   _status[index].name,
                    //           //     //   style: TextStyle(color: Colors.black54),
                    //           //     // ),
                    //           //     Text(
                    //           //       _status[index].price,
                    //           //       style: TextStyle(color: Colors.black54),
                    //           //     ),
                    //           //
                    //           //   ],
                    //           // ),
                    //           trailing: Padding(
                    //             padding: const EdgeInsets.only(right: 150.0),
                    //             child: Text(
                    //               _status[index].price,
                    //               style: TextStyle(color: Colors.black54),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       // ListTile(
                    //       //   leading: Padding(
                    //       //     padding: const EdgeInsets.only(left: 60),
                    //       //     child: Text(
                    //       //       _status[index].orderid,
                    //       //       style: TextStyle(color: Colors.black54),
                    //       //     ),
                    //       //   ),
                    //       //
                    //       //   title: Row(
                    //       //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       //     children: [
                    //       //       Text(
                    //       //         _status[index].date,
                    //       //         style: TextStyle(color: Colors.black54),
                    //       //       ),
                    //       //       Text(
                    //       //         _status[index].customer,
                    //       //         style: TextStyle(color: Colors.black54),
                    //       //       ),
                    //       //       Text(
                    //       //         _status[index].price,
                    //       //         style: TextStyle(color: Colors.black54),
                    //       //       ),
                    //       //       Container(
                    //       //         width: 75,
                    //       //         height: 30,
                    //       //         decoration: BoxDecoration(
                    //       //             color: _status[index].color
                    //       //         ),
                    //       //         child: Align(
                    //       //           alignment: Alignment.center,
                    //       //           child: Text(
                    //       //             _status[index].name,
                    //       //             style: TextStyle(color: Colors.white),
                    //       //           ),
                    //       //         ),
                    //       //       ),
                    //       //     ],
                    //       //   ),
                    //       //   trailing: IconButton(
                    //       //       onPressed: () {},
                    //       //       icon: Icon(
                    //       //         Icons.more_horiz_outlined,
                    //       //         color: Colors.black,
                    //       //       )
                    //       //   ),
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Showing 10 from 46 data",
                    //       style: TextStyle(
                    //         color: Colors.black87,
                    //       ),
                    //     ),
                    //     Container(
                    //         color: Colors.white,
                    //         child: Row(
                    //           children: [
                    //             if (ResponsiveLayout.isComputer(context))
                    //               ...List.generate(
                    //                 _pageNo.length,
                    //                 (index) => FlatButton(
                    //                   minWidth: 15,
                    //                   color: _currentSelectedButton1 == index
                    //                       ? Global.deepOrange
                    //                       : Colors.white,
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       _currentSelectedButton1 = index;
                    //                     });
                    //                   },
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(
                    //                         Constants.kPadding * 2),
                    //                     child: Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.center,
                    //                       children: [
                    //                         Text(
                    //                           _pageNo[index],
                    //                           style: TextStyle(
                    //                             color: _currentSelectedButton1 ==
                    //                                     index
                    //                                 ? Colors.black
                    //                                 : Colors.black87,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               )
                    //             else
                    //               Padding(
                    //                 padding: const EdgeInsets.all(
                    //                     Constants.kPadding * 2),
                    //                 child: Column(
                    //                   mainAxisAlignment: MainAxisAlignment.center,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.center,
                    //                   children: [
                    //                     Text(
                    //                       _buttonNames[_currentSelectedButton1],
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       margin: EdgeInsets.all(
                    //                           Constants.kPadding / 2),
                    //                       width: 60,
                    //                       height: 2,
                    //                       decoration: BoxDecoration(
                    //                         gradient: LinearGradient(
                    //                           colors: [
                    //                             Constants.red,
                    //                             Constants.orange,
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             IconButton(
                    //               onPressed: () {
                    //                 setState(() {
                    //                   // _currentSelectedButton1 ;
                    //                 });
                    //               },
                    //               icon: Icon(
                    //                 Icons.double_arrow,
                    //                 color: Colors.grey,
                    //               ),
                    //             )
                    //           ],
                    //         ))
                    //   ],
                    // )
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
