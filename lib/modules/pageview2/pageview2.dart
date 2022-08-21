import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/componment/defaultbuttom.dart';
import '../../shared/constant/constant.dart';

class PageView2 extends StatelessWidget {
  PageController controller;
  PageView2({required PageController this.controller});

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
              "assets/images/—Pngtree—business people dealing multi task_7260093.png"),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "managing time  problem",
          style: TextStyle(
              color: blackcolor,
              fontSize: width < 286 ? 18 : 25,
              fontWeight: FontWeight.bold),
          textAlign: width <= 300 ? TextAlign.right : TextAlign.center,
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "The problem is how we can do all this tasks and meetings without forgat anything or depass the deadline ",
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
