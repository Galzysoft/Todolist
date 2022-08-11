
import 'package:todoapp/screens/create_todo/create_todo.dart';

import '../../../constants/constants_and_imports.dart';

class TodoController extends ChangeNotifier {
void navigatetocreate(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTodo(),));
}
}