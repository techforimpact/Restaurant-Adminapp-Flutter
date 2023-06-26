import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../utils/global.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:csv/csv.dart';

import '../../utils/responsive.dart';

class CharityTable extends StatefulWidget {
  @override
  State<CharityTable> createState() => _CharityTableState();
}

class _CharityTableState extends State<CharityTable> {
  List<String> _banner = [
    "Sr.",
    "Customer ID",
    "Customer Name",
    "Charity",
  ];

  bool show = false;
  bool showItems = false;

  bool loader = true;
  List<Map<String, dynamic>> charityDataList = [];
  getCharityUser() async {
    int? charityCount = 0;
    List<Map<String, dynamic>> tempList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> tempMap = {};
      tempMap['uid'] = querySnapshot.docs[i].get('uid');
      tempMap['name'] = querySnapshot.docs[i].get('name');
      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('orders')
          .where('uid', isEqualTo: querySnapshot.docs[i].get('uid'))
          .get();
      for (var element in querySnapshot2.docs) {
        if (element.get('charity').toString() == '1') {
          charityCount = charityCount! + 1;
        }
      }
      tempMap['charity'] = charityCount;
      setState(() {
        tempList.add(tempMap);
      });
    }
    setState(() {
      charityDataList = tempList;
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCharityUser();
  }

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
          loader
              ? const Center(child: const CircularProgressIndicator())
              : Wrap(
                  children: List.generate(charityDataList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        height: 60,
                        child: Row(
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
                                child: Text(
                                  '${charityDataList[index]['uid']}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${charityDataList[index]['name']}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '\$${charityDataList[index]['charity']}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
          const SizedBox(
            height: 30,
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

    int? indexPrivate = 1;
    for (var element in charityDataList) {
      List<dynamic> dataRow = [];
      dataRow.add('$indexPrivate');
      dataRow.add('${element['uid']}');
      dataRow.add('${element['name']}');
      dataRow.add('${element['charity']}');
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
      ..download = 'charity.csv';
    //finally add the csv anchor to body
    html.document.body!.children.add(anchor);
    // Cause download by calling this function
    anchor.click();
    //revoke the object
    html.Url.revokeObjectUrl(url);
  }
}
