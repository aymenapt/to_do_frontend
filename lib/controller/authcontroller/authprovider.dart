import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/taskmodels.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? userid;

  bool? get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signup(var username, var email, var password) async {
    Uri url = Uri.parse('https://dourtasks.herokuapp.com/register/');
    try {
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'username': username,
            'email': email,
            'password': password,
          }));
      final resdata = json.decode(res.body);
      _token = resdata["token"];
      userid = resdata['id'];
      notifyListeners();
      final pref = await SharedPreferences.getInstance();
      final String userdata = json.encode({'token': _token, 'userid': userid});
      pref.setString('userdata', userdata);

      notifyListeners();
      if (resdata['non_field_errors'] != null) {
        throw "field to sign up";
      }
      print(res.body.toString());
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(username, password) async {
    Uri url = Uri.parse('https://dourtasks.herokuapp.com/login/');
    try {
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      final resdata = json.decode(res.body);
      _token = resdata["token"] ?? null;
      userid = resdata['id'];
      notifyListeners();
      final pref = await SharedPreferences.getInstance();
      final String userdata = json.encode({'token': _token, 'userid': userid});
      pref.setString('userdata', userdata);

      notifyListeners();
      if (resdata['non_field_errors'] != null) {
        throw "field to login";
      }
      print(res.body.toString());
    } catch (e) {
      throw e;
      print(e);
    }
  }

  //this function for auto login
  Future<bool> trylogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userdata')) {
      return false;
    }
    final extractdata =
        json.decode(pref.getString('userdata')!) as Map<String, dynamic>;
    _token = extractdata['token'];
    userid = extractdata['id'];
    notifyListeners();
    return true;
  }

  Future fetchtasks() async {
    final url = Uri.parse("https://dourtasks.herokuapp.com/tasks/");

    try {
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Token 97e7fac6537b488cda9517964977053c1999b2bb1dd19f57c0919f2351e12f6b',
        },
      );
      List responsedata = json.decode(res.body);
      var tasklist = [];
      TaskModels? object;
      for (int i = 0; i < responsedata.length; i++) {
        object = TaskModels.fromJson(responsedata[i]);
        tasklist.add(object);
      }
      print(responsedata[0]);
      print(object!.descreption);
      print(tasklist[0].title);
      print(_token);
      return tasklist;
    } catch (e) {
      print(e);
    }
  }

  Future<void> addtask(String title, String descreption, var task_date) async {
    Uri url = Uri.parse("https://dourtasks.herokuapp.com/tasks/");
    try {
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'Token 97e7fac6537b488cda9517964977053c1999b2bb1dd19f57c0919f2351e12f6b'
          },
          body: json.encode({
            'title': title,
            'description': descreption,
            'task_date': task_date
          }));
      print(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletetask(int id) async {
    Uri url = Uri.parse("https://dourtasks.herokuapp.com/tasks/$id/");
    try {
      final res = await http.delete(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Token 97e7fac6537b488cda9517964977053c1999b2bb1dd19f57c0919f2351e12f6b'
      });
      print(res.body);
    } catch (e) {
      print(e);
    }
  }
}
