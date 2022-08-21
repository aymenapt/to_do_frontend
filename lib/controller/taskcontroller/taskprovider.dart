import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/controller/authcontroller/authprovider.dart';
import 'package:todo_app/models/taskmodels.dart';


class TaskProvider with ChangeNotifier{

Future fetchtasks(BuildContext context) async{
final url =Uri.parse("https://dourtasks.herokuapp.com/tasks/");
var token =Provider.of<AuthProvider>(context,listen: false).token;
try{
final res =await http.get(url, headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':'Token $token'
          },) ;
var data =json.decode(res.body) ;
 var taskslist = TaskModels.fromJson(data) ;
  print(data);
return taskslist ;
}
catch(e){
  print(e);
}
}
}
