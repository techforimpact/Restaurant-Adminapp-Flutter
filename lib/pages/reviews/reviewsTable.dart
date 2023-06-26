// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../constants/style.dart';

import '../../../utils/global.dart';
import '../../models/restaurant.dart';
import 'dialog.dart';

class Status {
  String name;
  String orderid;
  bool enable;
  String date;
  String ratings;
  String restaurent;
  String customer;
  Color color;
  Status(
      {required this.name,
      required this.color,
      required this.orderid,
      required this.date,
      required this.ratings,
      required this.restaurent,
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
int _currentSelectedButton = 0;


class ReviewTable extends StatefulWidget {
  @override
  State<ReviewTable> createState() => _ReviewTableState();
}

class _ReviewTableState extends State<ReviewTable> {
  final List<String> _banner = [
    'Resturent Name',
    'Email',
    'Phone',
    'Address',
    'Review',
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
          const SizedBox(
            height: 20,
          ),
          // table header
          Container(
            color: Global.deepOrange,
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _banner.length,
                    (index) => Expanded(
                      child: FlatButton(
                        color: _currentSelectedButton == index
                            ? Global.deepOrange
                            : Global.deepOrange,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(Constants.kPadding * 2),
                          child: Text(
                            _banner[index],
                            style: const TextStyle(color: Colors.white),
                          ),
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
          // table content
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection('restaurants').get(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {

                var _status = <Restaurent>[];
                var data = snapshot.data!.docs;

                for (var element in data) {
                  _status.add(Restaurent.fromMap(element.data()));
                }
                print('data list ============> $data');

                return Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        padding: const EdgeInsets.only(left: 20, right: 40),
                        child: ListView.builder(
                            itemCount: _status.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                
                                 Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(_status[index].name)),
                                    Expanded(child: Text(_status[index].email)),
                                    Expanded(child: Text(_status[index].phone)),
                                    Expanded(child: Text(_status[index].address)),
                                      SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {
                              showDialog(context: context, builder: (context)=> Dialog(child: ViewReview(docId: data[index].id),));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: active,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'View Review',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ),
                     
                                  ],
                                ),
                              );
                            })));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
      
        ],
      ),
    );
  }
}
