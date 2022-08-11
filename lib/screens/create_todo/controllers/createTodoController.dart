import 'package:intl/intl.dart';
import 'package:todoapp/database/database.dart';

import '../../../constants/constants_and_imports.dart';

class CreateTodoController extends ChangeNotifier {
  String selectedTime = "Start Time";
  String selectedDate = "select Date";

  Future<void> createTodo(
      {required String todo_title,
      required String todo_description,
      required String todo_date,
      required String todo_time}) async {
    Databases.insertToDo(
        todo_title: todo_title,
        todo_description: todo_description,
        todo_date: todo_date,
        todo_time: todo_time).whenComplete(() => print("done inserting"));
  }

  String showCalender(BuildContext context) {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(DateTime.now().year);
    DateTime lastDate = DateTime(2100);

    showDatePicker(
            context: context,
            confirmText: "Select Todo Date",
            cancelText: "Cancel",
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate)
        .then((value) {
      if (value != null) {
        selectedDate = DateFormat("EEE,dd MMM, yyyy").format(value).toString();
      }
      notifyListeners();
    });
    notifyListeners();
    return selectedDate!;
  }

  String showTime(BuildContext context) {
    TimeOfDay initialTime = TimeOfDay.now();
    // TimeOfDay firstTime = DateTime(DateTime.now().year);
    // TimeOfDay lastDate = DateTime(2100);

    showTimePicker(
        context: context,
        confirmText: "Select Todo Time",
        cancelText: "Cancel",
        initialTime: initialTime,
        // builder: (context, childWidget) {
        //   return MediaQuery(
        //       data:
        //           MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        //       child: childWidget!);
        // }
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child!);
        }).then((value) {
      if (value != null) {
        selectedTime = value!.format(context);
        notifyListeners();
      }
    });
    notifyListeners();
    return selectedTime!;
  }
}
