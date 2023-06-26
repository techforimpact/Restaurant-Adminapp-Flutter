// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/review.dart';
import '../../utils/global.dart';

class ViewReview extends StatefulWidget {
  String docId;
  ViewReview({Key? key,required this.docId}) : super(key: key);

  @override
  State<ViewReview> createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {
  final List<String> _banner = [
    'Customer Name',
    'Average ratting',
    'Reveiw Time ',
    'Food items you collected ?',
    'Customer Service of Restaurent store? ',
    'Overall experience with Restaurent?',
    'Review',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
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
                        color: Global.deepOrange,
                        onPressed: () {},
                        child: Padding(
                          padding:  EdgeInsets.all(Constants.kPadding * 2),
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
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection('restaurants').doc(widget.docId).collection('review_ratting').get(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                var _status = <Review>[];
                var data = snapshot.data!.docs;
                for (var element in data) {
                  _status.add(Review.fromMap(element.data()));
                }
                print('data list ============> $data');

                if (_status.isNotEmpty) {
                    return Card(
                    color: Colors.white,
                    elevation: 3,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height*0.80 ,
                        child: ListView.builder(
                            itemCount: _status.length,
                            itemBuilder: (context, index) {
                              return Padding(
              padding: const EdgeInsets.only(right: 40),
                                child:
                                
                                 Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Align(
                                      alignment: Alignment.center,
                                      child: Text(_status[index].userName))),
                                    Expanded(child: Align(
                                      alignment: Alignment.center,
                                      
                                      child: Text(_status[index].avgRatings.toString()))),
                                    Expanded(child: Align(
                                      alignment: Alignment.center,
                                      
                                      child: Text(_status[index].dateTime.toString().substring(0,16)))),
                                    Expanded(child: Align(
                                      alignment: Alignment.center,
                                      
                                      child: Text(_status[index].ratingValue1.toString()))),
                                    Expanded(child: Align(
                                      alignment: Alignment.center,
                                      
                                      child: Text(_status[index].ratingValue2.toString()))),
                                    Expanded(child: Align(
                                      alignment: Alignment.center,
                                      
                                      child: Text(_status[index].ratingValue3.toString()))),
                                    Expanded(child: Align(
                                      alignment: Alignment.center,
                                      
                                      child: Text(_status[index].reviews))),
                                  ],
                                ),
                              );
                            })));
              
                }else{
                  return Center(
                    child: Text('NO RECORD FOUND',style: TextStyle(fontSize: 24),),
                  );
                }
              
              
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        
      ],
    );
  }
}