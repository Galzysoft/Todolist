import 'package:todoapp/screens/create_todo/create_todo.dart';
import 'package:todoapp/screens/todo/model/todo_model.dart';

import '../../../constants/constants_and_imports.dart';
import '../../../database/database.dart';

class TodoController extends ChangeNotifier {
  Future<List<TodoModel>>  get future async
  {
  return Databases.selctToDo();
  }

  void navigatetocreate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateTodo(),
        )).whenComplete(() => future);
  }
}
