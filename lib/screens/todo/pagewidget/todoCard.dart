import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    Key? key,
    required this.snapshot,

  }) : super(key: key);
  final snapshot;

  GlobalKey mykey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            shadowColor: Colors.purple,
            child: Dismissible(
              key: mykey,
              direction: DismissDirection.horizontal,
              onDismissed: (dismissdirection) {},
              background: Container(
                color: Colors.purple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 50,
                    ),
                  ],
                ),
              ),
              child: SizedBox(
                height: 100,
                child: ListTile(
                  leading: Icon(
                    Icons.notes,
                    color: Colors.purple,
                  ),
                  title: Text(
                   snapshot.title.toString(),
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                  ),
                  subtitle: Row(children: [
                    Icon(
                      Icons.date_range_outlined,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(snapshot.date.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400))
                  ]),
                  trailing: SizedBox(
                    width: 200,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          FittedBox(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.alarm_add_sharp,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(snapshot.time.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400))
                                ]),
                          )
                        ]),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          )),
    );
  }
}
