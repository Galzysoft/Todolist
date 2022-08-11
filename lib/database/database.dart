// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sqflite/sqflite.dart';

import 'package:todoapp/constants/constants_and_imports.dart';
import 'package:todoapp/screens/todo/model/todo_model.dart';

class Databases {
//   i create  a variable for storing our open db instance
  static Database? DB;

  static Future<void> dbconnector2() async {
    try {
//    lets define out db name
      String dbname = "/todo.db";
//lets get the mobile  default  db path
      String mobilepath = await getDatabasesPath();

      String dbpath = mobilepath + dbname;
      print("db pat $dbpath");
      // deleteDatabase(path)
//lets open our db with this db part

      DB = await openDatabase(dbpath, version: 3, onCreate: (db, version) {
        print("(yess we create it)");
      }, onOpen: (database) {
        DB = database;
        createTables(db: database);
      });
    } on Exception catch (e) {
      print("(yess we create it error) ");
    }
  }

  //  i want to create a  function for creating  my db tables
  static Future<void> createTables({var db}) async {
    ///  lets create  to_do table
    try {
      DB?.execute(
        '''create table ${Db_c.todoTable} ( ${Db_c.todo_title} text, ${Db_c.todo_description} text, ${Db_c.todo_date} text, ${Db_c.todo_time} text )''',
      );
      print("todoTable is created");
    } on Exception catch (e) {
      print("todoTable is not created ");
    }

    ///------------------------------------------------------------
  }

  static Future<void> insertToDo(
      {required String todo_title,
      required String todo_description,
      required String todo_date,
      required String todo_time}) async {
// statement method  insert values right inside the sql statement
//    insert into tablename (col1,col2,col3)  values(val1,val2,val3);
  print("my title $todo_title");
    try {
      DB?.execute(
          '''INSERT INTO ${Db_c.todoTable} (${Db_c.todo_title},${Db_c.todo_description}, ${Db_c.todo_date}, ${Db_c.todo_time}) values(?,?,?,?)''',
          [
            todo_title,
            todo_description,
            todo_date,
            todo_time
          ]).whenComplete(() {
        print("DONE INSERTED ");

        selctToDo();
      });
    } on Exception catch (e) {
      print("ERROR INSERTING $e");
    }
  }

  static Future<void> updateTodoa() async {
    try {
      await DB?.execute(
          "UPDATE ${Db_c.todoTable} Set ${Db_c.todo_description} = ? WHERE ${Db_c.todo_title}= ?",
          ["am happy", "aba"]);
      print("updated successfully");
      selctToDo();
    } on Exception catch (e) {
      print("not updated");
    }
  }

  static Future<void> deleteTodo() async {
    try {
      await DB?.execute(
          " DELETE FROM ${Db_c.todoTable} WHERE ${Db_c.todo_title} = ? ",
          ["aba"]);
      print("file deleted ");
    } on Exception catch (e) {
      print("delete failed $e");
      // TODO
    }
  }

  static Future<List<TodoModel>> selctToDo() async {
    var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable}");
  ///  select statement with a condition
  //   var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_title} = ? ",["onyeka"]);
    String v="onyeka";
    /// statement method
    // var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_title} = $v");
/// these is been used to perform search  querying of any appearance of  such values
//     var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_title} LIKE ? ",["%o%"]);
//     var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_description} LIKE ? OR ${Db_c.todo_title} LIKE ? ",["%good%","%london%"]);

    if (Result.length != 0) {

/// since our result is a list of map then we need to loop through it and store its ind
      /// individual element as an instance of  our todomodel and store it as a list
      ///
      // List<TodoModel> todoList=Result.map((json) => TodoModel.fromjson(json)).toList();
      List<TodoModel> todoList=[];
///or
      for(int i=0;i<Result.length;i++){
        Map mapresult=Result[i];
        /// let serialize the  mapresult and store it in an instance and store it in  our todoList
        todoList.add(TodoModel.fromjson(mapresult))  ;

      }

      print("Result is not empty  ${Result}");
      return todoList;


    } else {
      print("Result is  empty");
      return [];
    }
  }
}
