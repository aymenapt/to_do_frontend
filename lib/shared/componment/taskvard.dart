import 'package:flutter/material.dart';
import 'package:todo_app/shared/componment/defaultbuttom.dart';
import 'package:todo_app/shared/constant/constant.dart';

class TaskCard extends StatefulWidget {
  String title;
  String decription;
  String task_dt;
  Function deletetask;
  TaskCard(
      {Key? key,
      required this.title,
      required this.decription,
      required this.task_dt,
      required this.deletetask})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool istap = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 20),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: istap ? Color.fromARGB(255, 49, 174, 212) : whitecolor,
          boxShadow: [
            BoxShadow(
                color: Colors.black38, blurRadius: 6, offset: Offset(1, 4))
          ]),
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    istap = !istap;
                  },
                  child: Container(
                    child: istap
                        ? Icon(
                            Icons.done,
                            color: whitecolor,
                          )
                        : null,
                    margin: EdgeInsets.only(left: 20, top: 20),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: istap ? Colors.white70 : Colors.black26,
                            width: 2),
                        shape: BoxShape.circle),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: istap ? whitecolor : blackcolor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: istap ? Colors.white70 : Colors.black26,
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(

                            title: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Delete task ',
                                style: TextStyle(
                                    color: blackcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            
                            content: Container(
                              height: 200,
                              child: Column(children: [
                                Text(
                                  'Are you sure you want to delete this task ',
                                  style: TextStyle(color: blackcolor),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Defaultbutton(
                                    functon: () async {
                                      await widget.deletetask();
                                      Navigator.of(context).pop();
                                    },
                                    text: 'Delete',
                                    height: 40,
                                    width: 100,
                                    color: Color.fromARGB(255, 49, 174, 212)),
                                    SizedBox(height: 20,),
                                    Defaultbutton(
                                    functon: () async {
                                      Navigator.of(context).pop();
                                    },
                                    text: 'Cancle',
                                    height: 40,
                                    width: 100,
                                    color: Color.fromARGB(255, 49, 174, 212))
                              ]),
                            ),
                          ));
                },
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(left: 70, right: 20),
            child: Text(
              widget.decription,
              style: TextStyle(
                color: istap ? Colors.white70 : Colors.black45,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              widget.task_dt,
              style: TextStyle(
                color: istap ? Colors.white70 : Colors.black45,
                fontSize: 15,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
