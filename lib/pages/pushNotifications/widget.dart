

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../component/custom_text.dart';
import '../../../constants/style.dart';
import '../../models/style.dart';
/// Example without datasource
class NotificationTable extends StatefulWidget {
  const NotificationTable({Key? key}) : super(key: key);

  @override
  State<NotificationTable> createState() => _NotificationTableState();
}

class _NotificationTableState extends State<NotificationTable> with SingleTickerProviderStateMixin{

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
                    height: 30,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Add Notification',
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
                  Container(
                    height: 64,
                    width: 220,
                    decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(8),
                          child: TabBar(
                              unselectedLabelColor: Colors.white,
                              labelColor: active,
                              indicatorColor: active,
                              indicator: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(50),

                              ),
                              controller: tabController,
                              tabs: const [
                                Tab(
                                  text: 'Customers',
                                ),
                                Tab(
                                  text: 'Restaurent',
                                )
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                          controller: tabController,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          'Title',
                                          style: TextStyle(
                                            fontFamily:
                                            "Nunito",
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
                                    width: 500,
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
                                          hintText: "Enter Title..",
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          'Message',
                                          style: TextStyle(
                                            fontFamily:
                                            "Nunito",
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
                                    height: 300,
                                    width: 500,
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
                                      title: Align(
                                        alignment: Alignment.topLeft,
                                        child: TextField(
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
                                            hintText: "Message..",
                                            border: InputBorder.none,
                                          ),
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
                                  const SizedBox(
                                    height: 40,
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
                                                  'SEND',
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
                                  const SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: Text(
                                          'Title',
                                          style: TextStyle(
                                            color: active,
                                            fontSize: 18,
                                            fontFamily:
                                            "Nunito",
                                            fontWeight: FontWeight.w500,
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
                                    width: 500,
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
                                          hintText: "Enter Title..",
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Text(
                                          'Message',
                                          style: TextStyle(
                                            fontFamily:
                                            "Nunito",
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
                                    height: 300,
                                    width: 500,
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
                                      title: Align(
                                        alignment: Alignment.topLeft,
                                        child: TextField(
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
                                            hintText: "Message..",
                                            border: InputBorder.none,
                                          ),
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
                                  const SizedBox(
                                    height: 40,
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
                                                  'SEND',
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
                                  const SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          ])
                  )


                ],
              ),

            ),
          ),
        ],
      ),

    );
  }
}
