import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/controller/authcontroller/authprovider.dart';
import 'package:todo_app/controller/taskcontroller/taskprovider.dart';
import 'package:todo_app/layout/onboarding.layout/onboardingscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/layout/task.layout/taskscreen.dart';
import 'package:todo_app/modules/auth.modules/authscreen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  final pref = await SharedPreferences.getInstance();
  final obs = pref.getBool('obs') ?? false;

  print(obs);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_)=>AuthProvider()),
         ChangeNotifierProvider<TaskProvider>(create: (_)=>TaskProvider()),
      ],
      child: MyApp(
        obs: obs,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  bool obs;

  MyApp({
    Key? key,
    required this.obs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, value, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: obs
                ? (
                  FutureBuilder(
                  future: value.trylogin(),
                    builder: ((context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? TaskScreen()
                            : AuthScreen())))
                : SplachScreen()));
  }
}
