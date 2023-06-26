
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../component/custom_text.dart';
import '../../constants/controller.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import 'widgets/available_orders.dart';
import 'widgets/overview_cards_lage.dart';
import 'widgets/overview_cards_medium.dart';
import 'widgets/overview_vards_small.dart';
import 'widgets/revenue_section_large.dart';
import 'widgets/revenue_section_small.dart';


int? totalBites = 0;
int? totalOrders = 0;
int? totalCustomers = 0;

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    QuerySnapshot queryUsers = await FirebaseFirestore.instance
        .collection('users')
        .get();
    setState(() {
      totalCustomers = queryUsers.docs.length;
    });
    QuerySnapshot queryBites = await FirebaseFirestore.instance
        .collection('products')
        .get();
    setState(() {
      totalBites = queryBites.docs.length;
    });
    QuerySnapshot queryOrders = await FirebaseFirestore.instance
        .collection('orders')
        .get();
    setState(() {
      totalOrders = queryOrders.docs.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                 // color: Colors.red,
                margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 40,
                ),
                child: Text(
                   menuController.activeItem.value,
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: active
                  ),

                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomSize(context))
                const OverviewCardsMediumScreen()
              else
                const OverviewCardsLargeScreen()
            else
              OverviewCardsSmallScreen(),
            if (!ResponsiveWidget.isSmallScreen(context))
              RevenueSectionLarge()
            else
              RevenueSectionSmall(),
            RecentOrder(),
          ],
        )),
      ],
    );
  }
}
