import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/authcontroller/authprovider.dart';
import 'package:todo_app/shared/componment/defaultbuttom.dart';

import '../../shared/constant/constant.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _taskData = {
    'title': '',
    'descreption': '',
    'task_date': '',
  };
  TextEditingController? titelcontroller = TextEditingController();
  TextEditingController? descreptioncontroller = TextEditingController();
  DateTime? date;
  Future _submit() async {
    if (!_formKey.currentState!.validate() && date==null) {
      // Invalid!
      return;
    }
    var mydate = DateFormat('yyyy-MM-dd').format(date!);
    await Provider.of<AuthProvider>(context, listen: false).addtask(
        titelcontroller!.text, descreptioncontroller!.text, mydate.toString());

    print(mydate);
  }
showtoast(){
Fluttertoast.showToast(
        msg: 'please add date',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 49, 174, 212),
        textColor: Colors.white,
        fontSize: 16.0,

    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Color.fromARGB(255, 49, 174, 212),
            size: 50,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: whitecolor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Row(
              children: [
                Container(
                  color: Color.fromARGB(255, 12, 142, 182),
                  height: 2,
                  width: 80,
                  margin: EdgeInsets.only(left: 30, right: 5),
                ),
                Text(
                  'Add Task',
                  style: TextStyle(
                      color: Color.fromARGB(255, 49, 174, 212),
                      fontSize: 40,
                      fontStyle: FontStyle.italic),
                ),
                Container(
                  color: Color.fromARGB(255, 12, 142, 182),
                  height: 2,
                  width: 80,
                  margin: EdgeInsets.only(left: 5, right: 30),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                         // hintStyle: TextStyle(color:Color.fromARGB(255, 12, 142, 182) ),
                            
                            hintText: 'add title ',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 12, 142, 182)))),
                        controller: titelcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid title!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _taskData['title'] = value!;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        maxLines: 8,
                        decoration: InputDecoration(
                           // hintStyle: TextStyle(color:Color.fromARGB(255, 12, 142, 182) ),
                            
                            hintText: 'add descreption... ',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 12, 142, 182)))),
                        controller: descreptioncontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid title!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _taskData['descreption'] = value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Defaultbutton(
                          functon: () async {
                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2022),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2023));
                          },
                          text: 'pick date',
                          height: 40,
                          width: 200,
                          color: Color.fromARGB(255, 12, 142, 182)
                          ),
                      SizedBox(
                        height: 140,
                      ),
                      Defaultbutton(
                          functon: () async {
                          date==null?showtoast() : _submit();
                          },
                          text: 'add task',
                          height: 40,
                          width: 300,
                          color: Color.fromARGB(255, 49, 174, 212)
                          )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
