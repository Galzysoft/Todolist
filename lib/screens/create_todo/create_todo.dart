import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/database/database.dart';
import 'package:todoapp/screens/todo/controllers/todoController.dart';
import 'package:todoapp/screens/todo/model/todo_model.dart';
import 'package:todoapp/screens/todo/pagewidget/todoCard.dart';

import 'controllers/createTodoController.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  var _future;

  @override
  InitState() {

  }
TextEditingController title=TextEditingController();
  TextEditingController details=TextEditingController(text: " ");
  @override
  Widget build(BuildContext context) {
    var providerListenTrue =
        Provider.of<CreateTodoController>(context, listen: true);
    var providerListenFalse =
        Provider.of<CreateTodoController>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            providerListenFalse.createTodo(todo_title: title.text, todo_description: details.text, todo_date: providerListenTrue.selectedDate, todo_time: providerListenTrue.selectedTime);
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
                            style:
                                TextStyle(color: Colors.purple, fontSize: 40)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(children: [
        Padding(
            padding: const EdgeInsets.only(top: 13.0, left: 10, right: 10),
            child: SizedBox(
              height: 80,
              width: 300,
              child: TextFormField(controller: title,
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
              child: TextFormField(controller: details,
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
                onPressed: () {providerListenFalse.showCalender(context);},
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
                onPressed: () {providerListenFalse.showTime(context);},
                child: Row(
                  children: [
                    Icon(Icons.timer),
                    Text(providerListenTrue.selectedTime)
                  ],
                ))
          ],
        )
      ]),
    );
  }
}
