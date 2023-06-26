import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:csv/csv.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/custom_text.dart';
import '../../../constants.dart';
import '../../../constants/style.dart';
import '../../../responsive_layout.dart';
import '../../../utils/global.dart';
import '../../../utils/responsive.dart';
import 'customerDetails.dart';

class Status {
  String name;
  String orderid;
  bool enable;
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
      required this.customer,
      this.enable = false});
}

class Order {
  String name;
  Order({
    required this.name,
  });
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

class CustomerTable extends StatefulWidget {
  @override
  State<CustomerTable> createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {
  String dropdownvalue = 'All';

  late String valueChoose;
  var items = ['All', 'This Week', 'This Month', 'This Year'];

  List<String> _banner = [
    "Sr.",
    "Customer ID",
    "Email",
    "Customer Name",
    "Phone no.",
  ];

  bool show = false;
  bool showItems = false;

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
          Column(
            children: [
              const SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        child: const Text(
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
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Global.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
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
              ),
              const SizedBox(
                height: 5,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('role', isEqualTo: 'customer')
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
                            snapshot.data!.docs.length,
                            (index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            CustomerDetailsPage(
                                              userModel:
                                                  snapshot.data!.docs[index],
                                            )));
                              },
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          '${index + 1}',
                                          style:
                                              const TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.docs[index].id,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                .get('email'),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                .get('name'),
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                .get('phone'),
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                  }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> generateCSV() async {
    // we will declare the list of headers that we want
    List<String> rowHeader = _banner;
    // here we will make a 2D array to handle a row
    List<List<dynamic>> rows = [];
    //First add entire row header into our first row
    rows.add(rowHeader);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    int? indexPrivate = 1;
    for (var element in querySnapshot.docs) {
      List<dynamic> dataRow = [];
      dataRow.add('$indexPrivate');
      dataRow.add('${element.id}');
      dataRow.add('${element.get('email')}');
      dataRow.add('${element.get('name')}');
      dataRow.add('${element.get('phone').toString()}');
      //lastly add dataRow to our 2d list
      rows.add(dataRow);
      setState(() {
        indexPrivate = indexPrivate! + 1;
      });
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
      ..download = 'users.csv';
    //finally add the csv anchor to body
    html.document.body!.children.add(anchor);
    // Cause download by calling this function
    anchor.click();
    //revoke the object
    html.Url.revokeObjectUrl(url);
  }
}
