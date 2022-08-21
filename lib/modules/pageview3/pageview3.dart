import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/modules/auth.modules/authscreen.dart';

import '../../shared/componment/defaultbuttom.dart';
import '../../shared/constant/constant.dart';

class PageView3 extends StatelessWidget {
  PageController controller;
  PageView3({required PageController this.controller});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.13,
        ),
        Container(
          height: height * 0.4,
          child: Image.asset(
              "assets/images/—Pngtree—working time management illustration_6261226.png"),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          "aymen note",
          style: TextStyle(
              color: blackcolor,
              fontSize: width < 286 ? 18 : 25,
              fontWeight: FontWeight.bold),
          textAlign: width <= 300 ? TextAlign.right : TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Its so easy with aymen note you can manage your time and never forgot any task",
              style: TextStyle(
                color: blackcolor,
                fontSize: width < 286 ? 18 : 20,
              ),
              textAlign: TextAlign.left,
            )),
        SizedBox(
          height: height * 0.18,
        ),
        Defaultbutton(
            functon: () async {
              final pref = await SharedPreferences.getInstance();
              pref.setBool('obs', true);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => AuthScreen())));
            },
            width: width * 0.7,
            height: height * 0.05,
            color: botoumncolor,
            text: 'Create account'),
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
