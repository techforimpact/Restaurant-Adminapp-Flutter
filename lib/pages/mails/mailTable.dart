
import 'dart:html';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../component/custom_text.dart';
import '../../../constants/style.dart';
import '../../models/style.dart';
/// Example without datasource
class MailTable extends StatefulWidget {
  const MailTable({Key? key}) : super(key: key);

  @override
  State<MailTable> createState() => _MailTableState();
}

class _MailTableState extends State<MailTable> with SingleTickerProviderStateMixin{
  String dropdownvalue = 'Flat Discount';

  late String valueChoose;
  var items = [
    'Flat Discount',
    'Percentage Discount'
  ];

  late TabController tabController;
  @override
  void initState(){
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 600,
                // width: 550,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SMTP Details',
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black45
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      color: deepOrange.withOpacity(0.9),
                      height: 50,
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  const Text(
                                    'Host',
                                    style: TextStyle(
                                      fontFamily:
                                      "Nunito",
                                      fontWeight: FontWeight.w500,
                                      // fontStyle: FontStyle.normal,
                                      color: deepOrange,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    // height: 45,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: deepOrange.withOpacity(0.3),
                                            blurRadius: 8,

                                            offset: const Offset(0, 4), // changes position of shadow
                                          ),
                                        ]
                                    ),
                                    child: const ListTile(
                                      //SEARCH BAR
                                      title: TextField(
                                        //SEARCH BAR TYPO

                                        textInputAction:
                                        TextInputAction.search,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontFamily:
                                            "Nunito",
                                            fontWeight: FontWeight.w500,
                                            // fontStyle: FontStyle.normal,
                                            color: deepOrange,
                                            fontSize: 15,
                                          ),
                                          hintText: "Host",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                      //FILTER ICON


                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: 30, top: 5, bottom: 5),
                                      //   child: IconButton(
                                      //     icon: Icon(
                                      //       MyIcons.filter_icon,
                                      //       color: deepOrange,
                                      //     ),
                                      //     iconSize: 15,
                                      //     onPressed: () {
                                      //       showDialog(
                                      //           context: context,
                                      //           builder: (context) =>
                                      //               AlertDialog(
                                      //                 shape: RoundedRectangleBorder(
                                      //                     borderRadius:
                                      //                     BorderRadius
                                      //                         .circular(
                                      //                         30)),
                                      //                 title: Center(
                                      //                   child: Text(
                                      //                     'Select Your Type',
                                      //                     style: TextStyle(
                                      //                         fontFamily:
                                      //                         "Nunito",
                                      //                         fontSize: 14,
                                      //                         color: Colors
                                      //                             .black54,
                                      //                         fontWeight:
                                      //                         FontWeight
                                      //                             .w900),
                                      //                   ),
                                      //                 ),
                                      //                 content: Filter(),
                                      //               ));
                                      //     },
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                           Container(
                             child: Row(
                               children: [
                                 const Text(
                                   'Port',
                                   style: TextStyle(
                                     fontFamily:
                                     "Nunito",
                                     fontWeight: FontWeight.w500,
                                     // fontStyle: FontStyle.normal,
                                     color: deepOrange,
                                     fontSize: 18,
                                   ),
                                 ),
                                 const SizedBox(
                                   width: 10,
                                 ),
                                 Container(
                                   // height: 45,
                                   width: 300,
                                   decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius:
                                       BorderRadius.circular(20),
                                       boxShadow: [
                                         BoxShadow(
                                           color: deepOrange.withOpacity(0.3),
                                           blurRadius: 8,

                                           offset: const Offset(0, 4), // changes position of shadow
                                         ),
                                       ]
                                   ),
                                   child: const ListTile(
                                     //SEARCH BAR
                                     title: TextField(
                                       //SEARCH BAR TYPO

                                       textInputAction:
                                       TextInputAction.search,
                                       decoration: InputDecoration(
                                         hintStyle: TextStyle(
                                           fontFamily:
                                           "Nunito",
                                           fontWeight: FontWeight.w500,
                                           // fontStyle: FontStyle.normal,
                                           color: deepOrange,
                                           fontSize: 15,
                                         ),
                                         hintText: "Port",
                                         border: InputBorder.none,
                                       ),
                                     ),
                                     //FILTER ICON


                                     // Padding(
                                     //   padding: EdgeInsets.only(
                                     //       left: 30, top: 5, bottom: 5),
                                     //   child: IconButton(
                                     //     icon: Icon(
                                     //       MyIcons.filter_icon,
                                     //       color: deepOrange,
                                     //     ),
                                     //     iconSize: 15,
                                     //     onPressed: () {
                                     //       showDialog(
                                     //           context: context,
                                     //           builder: (context) =>
                                     //               AlertDialog(
                                     //                 shape: RoundedRectangleBorder(
                                     //                     borderRadius:
                                     //                     BorderRadius
                                     //                         .circular(
                                     //                         30)),
                                     //                 title: Center(
                                     //                   child: Text(
                                     //                     'Select Your Type',
                                     //                     style: TextStyle(
                                     //                         fontFamily:
                                     //                         "Nunito",
                                     //                         fontSize: 14,
                                     //                         color: Colors
                                     //                             .black54,
                                     //                         fontWeight:
                                     //                         FontWeight
                                     //                             .w900),
                                     //                   ),
                                     //                 ),
                                     //                 content: Filter(),
                                     //               ));
                                     //     },
                                     //   ),
                                     // ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Container(
                            child: Row(
                              children: [
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontFamily:
                                    "Nunito",
                                    fontWeight: FontWeight.w500,
                                    // fontStyle: FontStyle.normal,
                                    color: deepOrange,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  // height: 45,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: deepOrange.withOpacity(0.3),
                                          blurRadius: 8,

                                          offset: const Offset(0, 4), // changes position of shadow
                                        ),
                                      ]
                                  ),
                                  child: const ListTile(
                                    //SEARCH BAR
                                    title: TextField(
                                      //SEARCH BAR TYPO

                                      textInputAction:
                                      TextInputAction.search,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          fontFamily:
                                          "Nunito",
                                          fontWeight: FontWeight.w500,
                                          // fontStyle: FontStyle.normal,
                                          color: deepOrange,
                                          fontSize: 15,
                                        ),
                                        hintText: "Email",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    //FILTER ICON


                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: 30, top: 5, bottom: 5),
                                    //   child: IconButton(
                                    //     icon: Icon(
                                    //       MyIcons.filter_icon,
                                    //       color: deepOrange,
                                    //     ),
                                    //     iconSize: 15,
                                    //     onPressed: () {
                                    //       showDialog(
                                    //           context: context,
                                    //           builder: (context) =>
                                    //               AlertDialog(
                                    //                 shape: RoundedRectangleBorder(
                                    //                     borderRadius:
                                    //                     BorderRadius
                                    //                         .circular(
                                    //                         30)),
                                    //                 title: Center(
                                    //                   child: Text(
                                    //                     'Select Your Type',
                                    //                     style: TextStyle(
                                    //                         fontFamily:
                                    //                         "Nunito",
                                    //                         fontSize: 14,
                                    //                         color: Colors
                                    //                             .black54,
                                    //                         fontWeight:
                                    //                         FontWeight
                                    //                             .w900),
                                    //                   ),
                                    //                 ),
                                    //                 content: Filter(),
                                    //               ));
                                    //     },
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            Container(
                              child: Row(
                                children: [
                                  const Text(
                                    'Sender Id',
                                    style: TextStyle(
                                      fontFamily:
                                      "Nunito",
                                      fontWeight: FontWeight.w500,
                                      // fontStyle: FontStyle.normal,
                                      color: deepOrange,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    // height: 45,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: deepOrange.withOpacity(0.3),
                                            blurRadius: 8,

                                            offset: const Offset(0, 4), // changes position of shadow
                                          ),
                                        ]
                                    ),
                                    child: const ListTile(
                                      //SEARCH BAR
                                      title: TextField(
                                        //SEARCH BAR TYPO

                                        textInputAction:
                                        TextInputAction.search,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontFamily:
                                            "Nunito",
                                            fontWeight: FontWeight.w500,
                                            // fontStyle: FontStyle.normal,
                                            color: deepOrange,
                                            fontSize: 15,
                                          ),
                                          hintText: "Sender Id",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                      //FILTER ICON


                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: 30, top: 5, bottom: 5),
                                      //   child: IconButton(
                                      //     icon: Icon(
                                      //       MyIcons.filter_icon,
                                      //       color: deepOrange,
                                      //     ),
                                      //     iconSize: 15,
                                      //     onPressed: () {
                                      //       showDialog(
                                      //           context: context,
                                      //           builder: (context) =>
                                      //               AlertDialog(
                                      //                 shape: RoundedRectangleBorder(
                                      //                     borderRadius:
                                      //                     BorderRadius
                                      //                         .circular(
                                      //                         30)),
                                      //                 title: Center(
                                      //                   child: Text(
                                      //                     'Select Your Type',
                                      //                     style: TextStyle(
                                      //                         fontFamily:
                                      //                         "Nunito",
                                      //                         fontSize: 14,
                                      //                         color: Colors
                                      //                             .black54,
                                      //                         fontWeight:
                                      //                         FontWeight
                                      //                             .w900),
                                      //                   ),
                                      //                 ),
                                      //                 content: Filter(),
                                      //               ));
                                      //     },
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 50,
                                width:150 ,
                                child: ElevatedButton(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                        primary: active,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),

                                        )
                                    ),
                                    child:const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )

                  ],
                ),

              ),
            ),
          ],
        ),
      ),

    );
  }
}
