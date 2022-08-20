import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/database/database.dart';
import 'package:todoapp/screens/todo/controllers/todoController.dart';
import 'package:todoapp/screens/todo/model/todo_model.dart';
import 'package:todoapp/screens/todo/pagewidget/todoCard.dart';

import 'controllers/createTodoController.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key, this.snapshot}) : super(key: key);
  final snapshot;

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  var _future;
  TextEditingController? title;
  TextEditingController? details;

  @override
  initState() {
    print("my passed snapshot ${widget.snapshot}");
    title = TextEditingController(
        text: widget.snapshot == null ? "" : widget.snapshot.title);
    details = TextEditingController(
        text: widget.snapshot == null ? " " : widget.snapshot.description);
    super.initState();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var providerListenTrue =
        Provider.of<CreateTodoController>(context, listen: true);
    var providerListenFalse =
        Provider.of<CreateTodoController>(context, listen: false);

    /// we  make use of tyhe
    return WillPopScope(
      onWillPop: () async {
        print("ada");

        /// we want to return values back to the previos page  so we uses  Navigator.pop(context, "emma");
        if( widget.snapshot != null ) {
          bool update = await Databases.updateTodoa(
              todo_id: widget.snapshot.id,
              todo_title: title!.text,
              todo_description: details!.text,
              todo_date: providerListenTrue.selectedDate,
              todo_time: providerListenTrue.selectedTime);
          if (update) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(backgroundColor: Colors.green,
                content: Text("Updated Sucessfully")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Updated not Sucessfull")));
          }
          Navigator.pop(context, "emma");
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:widget.snapshot != null ?SizedBox() :FloatingActionButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                providerListenFalse.createTodo(
                    context: context,
                    todo_title: title!.text,
                    todo_description: details!.text,
                    todo_date: providerListenTrue.selectedDate,
                    todo_time: providerListenTrue.selectedTime);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("make sure you fill up all input fields")));
              }
            },
            elevation: 10,
            hoverElevation: 20,
            child: Icon(Icons.done_all_outlined)),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.purple.withOpacity(0.3),
                  Colors.white70,
                  Colors.white
                ])),
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Spacer(flex: 7,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Create Todo",
                              style: TextStyle(
                                  color: providerListenTrue.isdone
                                      ? Colors.green
                                      : Colors.purple,
                                  fontSize: 40)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Form(
          key: formkey,
          child: ListView(children: [
            Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 10, right: 10),
                child: SizedBox(
                  height: 80,
                  width: 300,
                  child: TextFormField(
                    controller: title,
                    validator: (validate) {
                      if (validate!.isEmpty) {
                        return "Title Required";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.notes),
                      labelText: "Title",
                      labelStyle: TextStyle(fontSize: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.purple),
                      ),
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 10, right: 10),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: details,
                    maxLines: 10,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.notes),
                      labelText: "Description",
                      labelStyle: TextStyle(fontSize: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.purple),
                      ),
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      providerListenFalse.showCalender(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.date_range_outlined),
                        Text(providerListenTrue.selectedDate)
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      providerListenFalse.showTime(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.timer),
                        Text(providerListenTrue.selectedTime)
                      ],
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
