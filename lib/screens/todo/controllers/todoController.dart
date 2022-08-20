import 'package:todoapp/screens/create_todo/create_todo.dart';
import 'package:todoapp/screens/todo/model/todo_model.dart';

import '../../../constants/constants_and_imports.dart';
import '../../../database/database.dart';

class TodoController extends ChangeNotifier {
  String searchterm="";

  set  searchterms(search ){
    searchterm=search;
    notifyListeners();
  }


  TodoController(){futureawait;}
    var  future;
  Future<List<TodoModel>>  get futureawait async
  {
/// reason for the change  is i want to store every thing   from our selecttod in a future variable  instead of  using just a get method
    future=Databases.selctToDo();
    notifyListeners();
  return  future;
  }
  Future <void> deleteTodo({required BuildContext context,required var id})async{
    Databases.deleteTodo(id: id).whenComplete(() async {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Todo Deleted")));
      await future;
      notifyListeners();
    });

  }

  /// our search algorithm
  Future<void> search({ required String searchterm})async{

future=Databases.searchToDo(searchterm);
notifyListeners();
  }


  Future <void> openCreateTodo({required BuildContext context,required snapshot})async{

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CreateTodo(snapshot: snapshot);
          },
        )).then((value) async {
      await  future;
notifyListeners();
      print(value);

    });
  }


  void navigatetocreate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateTodo(),
        )).whenComplete(() async {
           await future;
           notifyListeners();
        });
  }
}
