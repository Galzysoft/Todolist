import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/database/database.dart';
import 'package:todoapp/screens/todo/controllers/todoController.dart';
import 'package:todoapp/screens/todo/model/todo_model.dart';
import 'package:todoapp/screens/todo/pagewidget/todoCard.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {


  @override
  initState() {
    print("ada");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerListenTrue = Provider.of<TodoController>(context, listen: true);
    var providerListenFalse =
    Provider.of<TodoController>(context, listen: false);
    // providerListenTrue.futureawait;
    return ChangeNotifierProvider<TodoController>(
      create: (BuildContext context) => TodoController(),
      child: Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              providerListenFalse.navigatetocreate(context);
            },
            elevation: 10,
            hoverElevation: 20,
            child: Icon(Icons.add)),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Material(
            color: Color(0xffF0F0F0),
            elevation: 2,
            shadowColor: Colors.purple,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Spacer(flex: 7,),
                      Row(
                        children: [
                          Text("Todo",
                              style:
                              TextStyle(color: Colors.purple, fontSize: 40)),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 13.0, left: 10, right: 10),
                              child: SizedBox(
                                height: 80,
                                width: 300,
                                child: TextFormField(
                                  onChanged: (value) {
                                  print(value);
                                  providerListenFalse.searchterms=value;
                                  providerListenFalse.search(searchterm: value);
                                },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),


                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 2,
                                          color: Colors.purple),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<TodoModel>>(
            future: providerListenTrue.future,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.length != 0) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return TodoCard(
                        snapshot: snapshot.data![index],searchTerm: providerListenTrue.searchterm,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.length);
              } else {
                return Center(
                    child: CircularProgressIndicator(color: Colors.purple));
              }
            }),
      ),
    );
  }
}
