
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/style.dart';
import '../../models/style.dart';
import '../../utils/global.dart';
import '../../utils/responsive.dart';
import 'restaurentDetails.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:csv/csv.dart';

/// Example without datasource

class Person {
  String orderid;
  String address;
  String menu;
  String contact;
  String quantity;
  String ratings;
  String status;
  Color color;
  Person(
      {required this.color,
      required this.orderid,
      required this.address,
      required this.quantity,
      required this.ratings,
      required this.status,
      required this.menu,
      required this.contact});
}



class BitesHubTable extends StatefulWidget {
  @override
  State<BitesHubTable> createState() => _BitesHubTableState();
}

class _BitesHubTableState extends State<BitesHubTable> {
  var buttonText = 'Active';
  bool pressed = true;
  bool isSelected = true;

  List<String> _banner = [
    "Sr.",
    "Image",
    "Name",
    "Address",
    "Contact",
    "Ratings",
    "Commission",
    "Status"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: 20,
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
                  .collection('restaurants')
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
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => RestaurentDetailsPage(
                                            restModel:
                                                snapshot.data!.docs[index],
                                          )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SizedBox(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image.network(
                                              '${snapshot.data!.docs[index].get('image')}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '${snapshot.data!.docs[index].get('name')}',
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              '${snapshot.data!.docs[index].get('id')}',
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Text(
                                    // _persons[index].name,
                                    // style: TextStyle(
                                    // color: Colors.black87,
                                    // fontWeight: FontWeight.w700
                                    // ),
                                    // ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '${snapshot.data!.docs[index].get('address')}',
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '${snapshot.data!.docs[index].get('email')}',
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ),

                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          '0',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          commissionDialogue(
                                              context: context,
                                              id: snapshot
                                                  .data!.docs[index].id);
                                        },
                                        child: Center(
                                          child: Text(
                                            '${snapshot.data!.docs[index].get('commission')}%',
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'restaurants')
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .update({
                                                      'isActive': snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      'isActive')
                                                                  .toString() ==
                                                              'true'
                                                          ? false
                                                          : true
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    primary: snapshot.data!
                                                                .docs[index]
                                                                .get('isActive')
                                                                .toString() ==
                                                            'true'
                                                        ? active
                                                        : Colors.black38,
                                                  ),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      'isActive')
                                                                  .toString() ==
                                                              'true'
                                                          ? const Text("Active")
                                                          : const Text("Inactive"))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    // Text(
                                    //   _persons[index].status,
                                    //   style: TextStyle(
                                    //       color: Colors.black54,
                                    //       fontWeight: FontWeight.w700
                                    //   ),
                                    // ),
                                  ],
                                ),
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
        ],
      ),
    );
  }

  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController controller = TextEditingController();
  void commissionDialogue({BuildContext? context, String? id}) {
    showDialog(
        barrierDismissible: true,
        context: context!,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: Container(
                width: Get.width / 1.5,
                // height: 400,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Text(
                                  'Commission',
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w500,
                                    // fontStyle: FontStyle.normal,
                                    color: deepOrange,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            // height: 45,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: deepOrange.withOpacity(0.3),
                                    blurRadius: 8,

                                    offset: const Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ]),
                            child: ListTile(
                              //SEARCH BAR
                              title: TextField(
                                controller: controller,
                                //SEARCH BAR TYPO
                                textInputAction: TextInputAction.search,
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w500,
                                    // fontStyle: FontStyle.normal,
                                    color: deepOrange,
                                    fontSize: 15,
                                  ),
                                  // hintText: "Enter Code..",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                                        Navigator.pop(context);
                                        FirebaseFirestore.instance
                                            .collection('restaurants')
                                            .doc(id)
                                            .update({
                                          'commission': int.parse(
                                              controller.text.toString())
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: active,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          )),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'UPDATE',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  Future<void> generateCSV() async {
    // we will declare the list of headers that we want
    List<String> rowHeader = [
      "Sr.",
      "Id",
      "Name",
      "Address",
      "Contact",
      "Commission",
      "Status"
    ];
    // here we will make a 2D array to handle a row
    List<List<dynamic>> rows = [];
    //First add entire row header into our first row
    rows.add(rowHeader);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('restaurants').get();

    int? indexPrivate = 1;
    for (var element in querySnapshot.docs) {
      List<dynamic> dataRow = [];
      dataRow.add('$indexPrivate');
      dataRow.add('${element.get('id')}');
      dataRow.add('${element.get('name')}');
      dataRow.add('${element.get('address')}');
      dataRow.add('${element.get('email')}');
      dataRow.add('${element.get('commission')}%');
      dataRow.add('${element.get('isActive')}');
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
      ..download = 'restaurent_report.csv';
    //finally add the csv anchor to body
    html.document.body!.children.add(anchor);
    // Cause download by calling this function
    anchor.click();
    //revoke the object
    html.Url.revokeObjectUrl(url);
  }
}
