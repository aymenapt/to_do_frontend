import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/authcontroller/authprovider.dart';
import 'package:todo_app/controller/taskcontroller/taskprovider.dart';
import 'package:todo_app/models/taskmodels.dart';
import 'package:todo_app/modules/addnote.modules/addnoteascreen.dart';
import 'package:todo_app/shared/componment/taskvard.dart';
import 'package:todo_app/shared/constant/constant.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List? tasklist;
  fetchdata() async {
    tasklist =
        await Provider.of<AuthProvider>(context, listen: false).fetchtasks();
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aymen Note'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 49, 174, 212),
      ),
      backgroundColor: whitecolor,
      body: RefreshIndicator(
          onRefresh: () async {
            await fetchdata();
          },
          child:Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  tasklist == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: tasklist!
                              .map((e) =>  TaskCard(
                                    title: e.title,
                                    decription: e.descreption,
                                    task_dt: e.task_date,
                                    deletetask: () async {
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .deletetask(e.id);
                                      int index = tasklist!.indexWhere(
                                        (element) => element.id == e.id,
                                      );
                                      setState(() {
                                            tasklist!.removeAt(index);
                                      });
                                    },
                                  ))
                              .toList(),
                        )
                ]),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => AddNoteScreen())),
        backgroundColor: Color.fromARGB(255, 49, 174, 212),
        child: Icon(Icons.add),
      ),
    );
  }
}
