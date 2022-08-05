// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sqflite/sqflite.dart';

import 'package:todoapp/constants/constants_and_imports.dart';

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

  static Future<void> insertToDo() async {
// statement method  insert values right inside the sql statement
//    insert into tablename (col1,col2,col3)  values(val1,val2,val3);
try{
    DB?.execute(
        '''INSERT INTO ${Db_c.todoTable} (${Db_c.todo_title}, ${Db_c.todo_description}, ${Db_c.todo_date}, ${Db_c.todo_time}) values(?,?,?,?)''',
        ["london",
          "a stupid place",
          "2022,10,4",
          "1:00 pm"
        ]
    ).whenComplete(() {
      print("DONE INSERTING ");
      selctToDo();
    });

}on Exception catch(e){
  print("ERROR INSERTING $e");
}

  }
  static Future<void> selctToDo() async{
    var Result= await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable}");
    if(Result.length==0){
      print("empty ");
    } else{print("Result is not empty  $Result");}

  }

}
