//
// import 'dart:convert';
//
// import 'package:admin_bite/page/pages/about.dart';
// import 'package:admin_bite/page/pages/home.dart';
// import 'package:admin_bite/page/pages/projects.dart';
// import 'package:admin_bite/page/pages/skills.dart';
// import 'package:admin_bite/pages/orders/orders.dart';
// import 'package:admin_bite/utils/global.dart';
// import 'package:admin_bite/utils/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'components/buttonChat.dart';
// import 'components/buttonMenu.dart';
//
//
//
// class PageHome extends StatefulWidget {
//   @override
//   _PageHomeState createState() => _PageHomeState();
// }
//
// class _PageHomeState extends State<PageHome> {
//   int page = 0;
//   bool show = false;
//   dynamic data;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadJson();
//     Future.delayed(
//       const Duration(microseconds: 20),
//       () => setState(
//         () {
//           show = true;
//         },
//       ),
//     );
//   }
//
//   loadJson() async {
//     String response = await rootBundle.loadString('page.json');
//     dynamic jsonResult = json.decode(response);
//     setState(() {
//       data = jsonResult;
//     });
//   }
//
//   // List<Widget> pages = [TabHome()];
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         child: Row(
//           children: [
//             if (isMobile(context) == false)
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 1000),
//                 decoration: BoxDecoration(
//                   color: Global.deepOrange,
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(20),
//                       bottomRight: Radius.circular(20)),
//                 ),
//                 width: show ? size.width / 6 : 0.0,
//                 height: size.height,
//                 child: SingleChildScrollView(
//                   child: Container(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 150,
//                         ),
//                         // Container(
//                         //   height: 150,
//                         //   child: Container(
//                         //     width: 100,
//                         //     height: 100,
//                         //
//                         //     // decoration: BoxDecoration(
//                         //     //   shape: BoxShape.circle,
//                         //     //   // radius: 50.0,
//                         //     //   //backgroundColor: Colors.white,
//                         //     //   image: DecorationImage(
//                         //     //       fit: BoxFit.contain,
//                         //     //       image: NetworkImage(
//                         //     //           'https://codigopanda.nyc3.digitaloceanspaces.com/images/placehodler.jpg')),
//                         //     // ),
//                         //   ),
//                         // ),
//                         ButtonMenu(
//                           durationAnimation: 1,
//                           icon: Icons.home,
//                           text: "Dashboard",
//                           selected: page == 0,
//                           onClik: () {
//
//                             page == 0;
//                             // setState(() {
//                             //   page = 0;
//                             // }
//                             // );
//                           },
//                         ),
//                         ButtonMenu(
//                           durationAnimation: 1,
//                           text: "Orders",
//                           icon: Icons.swap_vert,
//                           selected: page == 1,
//                           onClik: () {
//                            page ==1;
//                             // setState(() {
//                             //   page = 1;
//                             // });
//                           },
//                         ),
//                         ButtonMenu(
//                           durationAnimation: 1,
//                           text: "Bite",
//                           icon: Icons.fastfood_outlined,
//                           selected: page == 2,
//                           onClik: () {
//                             page =2;
//                             // setState(() {
//                             //   page = 2;
//                             // });
//                           },
//                         ),
//                         // ButtonMenu(
//                         //   durationAnimation: 1,
//                         //   text: "Restaurent",
//                         //   icon: Icons.people_alt_rounded,
//                         //   selected: page == 3,
//                         //   onClik: () {
//                         //     setState(() {
//                         //       page = 3;
//                         //     });
//                         //   },
//                         // ),
//
//                         ButtonMenu(
//                           durationAnimation: 1,
//                           text: "Restaurent",
//                           icon: Icons.restaurant_menu_outlined,
//                           selected: page == 3,
//                           onClik: () {
//                             page = 3;
//                             // setState(() {
//                             //   page = 3;
//                             // });
//                           },
//                         ),
//                         // ButtonMenu(
//                         //   durationAnimation: 1,
//                         //   text: "Analytics",
//                         //   icon: Icons.analytics_outlined,
//                         //   selected: page == 2,
//                         //   onClik: () {
//                         //     setState(() {
//                         //       page = 2;
//                         //     });
//                         //   },
//                         // ),
//                         // ButtonMenu(
//                         //   durationAnimation: 1,
//                         //   text: "Works",
//                         //   icon: Icons.work_outline,
//                         //   selected: page == 3,
//                         //   onClik: () {
//                         //     setState(() {
//                         //       page = 3;
//                         //     });
//                         //   },
//                         // ),
//
//                         ButtonMenu(
//                           durationAnimation: 1,
//                           text: "Customer",
//                           icon: Icons.people_alt_rounded,
//                           selected: page == 4,
//                           onClik: () {
//                             page = 4;
//                             // setState(() {
//                             //   page = 4;
//                             // });
//                           },
//                         ),
//                         // ButtonMenu(
//                         //   durationAnimation: 1,
//                         //   text: "Contact",
//                         //   icon: Icons.contact_mail_outlined,
//                         //   selected: page == 5,
//                         //   onClik: () {
//                         //     setState(() {
//                         //       page = 5;
//                         //     });
//                         //   },
//                         // ),
//                         // ButtonMenu(
//                         //   durationAnimation: 1,
//                         //   text: "Portofolio",
//                         //   selected: page == 4,
//                         //   onClik: () {
//                         //     setState(() {
//                         //       page = 4;
//                         //     });
//                         //   },
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             Flexible(
//                 child:
//                 // LayoutBuilder(
//                 //     builder: (BuildContext context, BoxConstraints constraints){
//                 //   if
//                 //
//                 //     }
//                 //
//                 // )
//
//                 LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//
//               if (page == 0) {
//                   return TabHome(widthX: constraints.maxWidth,);
//                 }
//                 if (page == 1) {
//                   return TabAbout(widthX: constraints.maxWidth);
//                 }
//                 if (page == 2) {
//                   return TabSkill(widthX: constraints.maxWidth);
//                 }
//                 // if (page == 4) {
//                 //   return OrderPage(widthX: constraints.maxWidth);
//                 // }
//                 if (page == 3) {
//                   return TabProject(widthX: constraints.maxWidth, data: data['page_projects']);
//
//                 }return TabHome(widthX: constraints.maxWidth,);
//                 // if (page == 5) {
//                 //   return new TabContact(
//                 //       widthX: constraints.maxWidth);
//                 // }
//               },
//             )
//             )
//           ],
//         ),
//       ),
//       // floatingActionButton: ButtonChat(),
//     );
//   }
// }
