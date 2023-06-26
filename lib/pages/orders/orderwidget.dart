import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../constants/style.dart';
import '../../constants.dart';
import '../../responsive_layout.dart';
import '../../utils/global.dart';
import 'package:universal_html/html.dart' as html;
import 'package:intl/intl.dart';

import '../../utils/responsive.dart';
import 'orderDetails.dart';

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

class Order {
  String name;

  Order({
    required this.name,
  });
}

List<String> _buttonNames = [
  "Pending Approval",
  "Collection In Process",
  "Order Completed"
];
List<String> _pageNo = ["1", "2", "3", "4"];
int _currentSelectedButton = 0;
int _currentSelectedButton1 = 1;

class OrderWidget extends StatefulWidget {
  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  String dropdownvalue = 'All';

  late String valueChoose;
  var items = ['All', 'This Week', 'This Month', 'This Year'];

  List<String> _banner = [
    "Sr.",
    "Order ID",
    "Date",
    "Customer",
    "Amount",
    "Status Order",
  ];

  // List<Status> _status = [
  //   Status(name: "Pending", color: Color(0xfff8b250), orderid: "#5552351", date: "26 March 2020, 12:42 AM", customer: "James WItcwicky", price: "\$164.52" ),
  //   Status(name: "Delivered", color: Color(0xff13d38e), orderid:"#5552323", date: "26 March 2020, 12:42 AM", customer: "Veronica", price: "\$74.92"),
  //   Status(name: "Cancelled", color: Colors.grey, orderid:"#5552375", date: "26 March 2020, 02:12 AM", customer: "Emilia Johanson", price: "\$251.16"),
  //   Status(name: "Pending", color: Color(0xfff8b250), orderid: "#5552311", date: "26 March 2020, 12:42 AM", customer: "Olivia Shine", price: "\$82.46"),
  //   Status(name: "Delivered", color: Color(0xff13d38e), orderid: "#5552388", date: "26 March 2020, 12:42 AM", customer: "Jessica Wong", price: "\$24.17"),
  //   Status(name: "Pending", color: Color(0xfff8b250), orderid: "#5552322", date: "26 March 2020, 01:42 PM", customer: "David Horison", price: "\$24.55"),
  //   Status(name: "Cancelled", color: Colors.grey, orderid: "#5552322", date: "26 March 2020, 01:42 PM", customer: "Samantha Bake", price: "\$22.18"),
  //   Status(name: "Cancelled", color: Colors.grey, orderid: "#5552397", date: "26 March 2020, 01:42 PM", customer: "Franky Sihotang", price: "\$45.86"),
  //   Status(name: "Delivered", color: Color(0xff13d38e), orderid: "#5552349", date: "26 March 2020, 01:42 PM", customer: "Roberto Carlo", price: "\$34.41"),
  //   Status(name: "Delivered", color: Color(0xff13d38e), orderid: "#5552356", date: "26 March 2020, 01:42 PM", customer: "Rendy Greenlee", price: "\$44.99"),
  // ];
  bool show = false;
  bool showItems = false;

  String showOrderType = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (ResponsiveLayout.isComputer(context))
                ...List.generate(
                  _buttonNames.length,
                  (index) => FlatButton(
                    color: _currentSelectedButton == index
                        ? Global.deepOrange
                        : Global.color,
                    onPressed: () {
                      setState(() {
                        _currentSelectedButton = index;
                        if (index == 0) {
                          showOrderType = 'Pending';
                        }
                        if (index == 1) {
                          showOrderType = 'Accepted';
                        }
                        if (index == 2) {
                          showOrderType = 'Complete';
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(Constants.kPadding * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _buttonNames[index],
                            style: TextStyle(
                              color: _currentSelectedButton == index
                                  ? Colors.black
                                  : Colors.black87,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.all(Constants.kPadding / 2),
                            width: 60,
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: _currentSelectedButton == index
                                  ? const LinearGradient(
                                      colors: [
                                        Constants.red,
                                        Constants.orange,
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(Constants.kPadding * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _buttonNames[_currentSelectedButton],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(Constants.kPadding / 2),
                        width: 60,
                        height: 2,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Constants.red,
                              Constants.orange,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'From',
                      style: TextStyle(color: customThemeColor, fontSize: 14),
                    ),
                    fromDate == null
                        ? const SizedBox()
                        : Text(fromDate.toString().substring(0, 10).toString())
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  _selectToDate(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'To',
                      style: TextStyle(color: customThemeColor, fontSize: 14),
                    ),
                    toDate == null
                        ? const SizedBox()
                        : Text(toDate.toString().substring(0, 10).toString())
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  generateCSV();
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: customThemeColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Text(
                      'Export',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
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
                  .where('status', isEqualTo: showOrderType)
                  // .orderBy('date_time', descending: true)
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
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        DateTime dt = (snapshot.data!.docs[index]
                                .get('date_time') as Timestamp)
                            .toDate();
                        return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('uid',
                                    isEqualTo:
                                        snapshot.data!.docs[index].get('uid'))
                                .snapshots(),
                            builder: (context, snapshot1) {
                              if (snapshot1.hasData) {
                                if (snapshot1.data!.docs.isEmpty) {
                                  return const SizedBox();
                                } else {
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
                                          await FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .where(
                                                  "uid",
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
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${ DateFormat('dd-MM-yy kk:mm').format(dt).toString().substring(0, 10)} - ${dt.toString().substring(11, 16)}',
                                                style: const TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${snapshot1.data!.docs[0].get('name')}',
                                                textAlign: TextAlign.center,
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
                                                decoration: BoxDecoration(
                                                  color: showOrderType ==
                                                          'Complete'
                                                      ? Colors.green
                                                      : const Color(0xfff8b250),
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
                            });
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
    );
  }

  DateTime? fromDate = DateTime.now().subtract(const Duration(days: 60));
  DateTime? toDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate!, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
      });
    }
  }

  _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate!, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
      });
    }
  }

  Future<void> generateCSV() async {
    // we will declare the list of headers that we want
    List<String> rowHeader = _banner;
    // here we will make a 2D array to handle a row
    List<List<dynamic>> rows = [];
    //First add entire row header into our first row
    rows.add(rowHeader);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('orders').get();

    int? indexPrivate = 1;
    for (var element in querySnapshot.docs) {
      List<dynamic> dataRow = [];
      DateTime dt = (element.get('date_time') as Timestamp).toDate();
      if (dt.isAfter(fromDate!.subtract(const Duration(days: 1))) &&
          dt.isBefore(toDate!.add(const Duration(days: 1)))) {
        dataRow.add('$indexPrivate');
        dataRow.add('${element.get('id')}');
        dataRow.add(
            '${dt.toString().substring(0, 10)} - ${dt.toString().substring(11, 16)}');
        dataRow.add('${element.get('uid')}');
        dataRow.add('\$${element.get('net_price')}');
        dataRow.add('${element.get('status')}');
        //lastly add dataRow to our 2d list
        rows.add(dataRow);
        setState(() {
          indexPrivate = indexPrivate! + 1;
        });
      }
    }
    //now convert our 2d array into the csvlist using the plugin of csv
    String csv = const ListToCsvConverter().convert(rows);
    //this csv variable holds entire csv data
    //Now Convert or encode this csv string into utf8
    final bytes = utf8.encode(csv);
    //NOTE THAT HERE WE USED HTML PACKAGE
    final blob = html.Blob([bytes]);
    //It will create downloadable object
    final url = html.Url.createObjectUrlFromBlob(blob);
    //It will create anchor to download the file
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'orders.csv';
    //finally add the csv anchor to body
    html.document.body!.children.add(anchor);
    // Cause download by calling this function
    anchor.click();
    //revoke the object
    html.Url.revokeObjectUrl(url);
  }
}
