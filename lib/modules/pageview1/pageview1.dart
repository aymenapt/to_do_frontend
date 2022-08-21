import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/componment/defaultbuttom.dart';
import '../../shared/constant/constant.dart';

class PageView1 extends StatelessWidget {
  PageController controller;
  PageView1({required PageController this.controller});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.09,
        ),
        Container(
          child: Image.asset(
              "assets/images/—Pngtree—flat wind clock man time_5780889.png"),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "manage time",
          style: TextStyle(
              color: blackcolor,
              fontSize: width < 286 ? 18 : 25,
              fontWeight: FontWeight.bold),
          textAlign: width <= 300 ? TextAlign.right : TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Day after dat we become more busy cause our nature life :tasks,life commitments.. and this made a big problem",
              style: TextStyle(
                color: blackcolor,
                fontSize: width < 286 ? 18 : 20,
              ),
              textAlign: TextAlign.left,
            )),
        SizedBox(
          height: height * 0.15,
        ),
        Defaultbutton(
            functon: () {
              controller.nextPage(
                  duration: Duration(milliseconds: 700), curve: Curves.easeIn);
            },
            width: width * 0.7,
            height: height * 0.05,
            color: botoumncolor,
            text: 'Next'),
        const SizedBox(
          height: 16,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          axisDirection: Axis.horizontal,
          effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Color.fromARGB(255, 117, 114, 119),
              activeDotColor: Color.fromARGB(255, 49, 174, 212)),
        ),
      ],
    );
  }
}
