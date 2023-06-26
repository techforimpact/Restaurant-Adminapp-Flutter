import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/reundedButton.dart';
import 'login_signup/constants.dart';
import 'utils/global.dart';
import 'utils/responsive.dart';


class PageIntro extends StatefulWidget {
  PageIntro({Key? key, required this.startAnimation}) : super(key: key);

  Function startAnimation;

  @override
  _PageIntroState createState() => _PageIntroState();
}

class _PageIntroState extends State<PageIntro> {
  late Uint8List imageData;

  Option selectedOption = Option.LogIn;

  void loadAsset() async {
    Uint8List data = (await rootBundle.load('main.png')).buffer.asUint8List();
    setState(() => this.imageData = data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAsset();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: isMobile(context)
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      if(isMobile(context) ==true)
                      // Image.asset(
                      //   'main.png',
                      //   height: size.height * 0.5,
                      // ),
                      RichText(
                        text: TextSpan(
                            text: "Welcome! To Book-A-Table",
                            style: TextStyle(
                                fontSize: isDesktop(context) ? 50 : 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.green)),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //           text:
                      //               "I'm Victor Rodas. I’ve spent 3 years creating design that's founded on research and driven by strategy. I do things differently, using a lightweight approach to generate quick, tangible results that improve the performance of your website or app.",
                      //           style: TextStyle(
                      //               fontSize: isDesktop(context) ? 16 : 8,
                      //               fontWeight: FontWeight.w800,
                      //               color: Colors.black54)),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: isMobile(context) ? double.infinity : 300,
                        child: RoundedButton(
                            buttonName: "Know about us more!",
                            icon: Icons.person,
                            onTap: () {
                              widget.startAnimation();
                            },
                            height: 50.0,
                            borderWidth: 1.0,
                            buttonColor: Colors.transparent,
                            textColor: Colors.black26,
                            borderColor: Global.deepOrange, width: 5,),
                      ),
                    ],
                  ),
                ),
              ),
              //Expanded(child: instantiateImageCodec(imageData))
              if ((isTab(context) || isDesktop(context)) && imageData != null)
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(455.0),
                    child: Image.asset(
                      'Logo.png',
                      height: size.height * 0.7,
                    ),
                  )
                ),
              // if ((isTab(context) || isDesktop(context)) && imageData!=null)
              //    Expanded(
              //        child: Image.memory(
              //          imageData,
              //      height: size.height * 0.7,
              //    ))
            ],
          ),
        ],
      ),
    );
  }
}
