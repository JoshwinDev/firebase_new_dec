import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_task_firebase_june_ndz/src/cubit/tasks/tasks_cubit.dart';
import 'package:my_task_firebase_june_ndz/src/models/task_model.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create a task"),
        ),
        body: Form(child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: "Title"
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: "Description"
              ),
            ),
            TextFormField(
              controller: _startDateController,
              readOnly: true,
              onTap: () async {
                startDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime.now(), lastDate: DateTime(2030)
                );
                if (startDate != null) {
                  _startDateController.text = startDate.toString();
                }
              },
              decoration: InputDecoration(
                  labelText: "Start Date"
              ),
            ),
            TextFormField(
              controller: _endDateController,
              readOnly: true,
              onTap: () async {
                endDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime.now(), lastDate: DateTime(2030)
                );
                if (endDate != null) {
                  _endDateController.text = endDate.toString();
                }
              },
              decoration: InputDecoration(
                  labelText: "End Date"
              ),
            ),
            SizedBox(height: 20,),
            BlocConsumer<TasksCubit, TasksState>(
              listener: (context, state) {
               if(state is TasksCreated){
                 Navigator.pop(context);
               }else if(state is TasksCreateError){
                 Fluttertoast.showToast(
                     msg: "Error creating the task",
                     toastLength: Toast.LENGTH_LONG,
                     gravity: ToastGravity.SNACKBAR,
                     timeInSecForIosWeb: 1,
                     backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 16.0
                 );
               }
              },
              builder: (context, state) {
                if(state is TasksCreating){
                  return CircularProgressIndicator();
                }
                return ElevatedButton(onPressed: () {
                  TaskModel taskModel = TaskModel(
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      startDate: startDate ?? DateTime.now(),
                      endDate: endDate ?? DateTime.now().add(Duration(days: 5)),
                      isCompleted: false);

                  context.read<TasksCubit>().createTasks(taskModel);
                }, child: Text("Create Task"));
              },
            )
          ],
        ),
        ),
      ),
    );
  }
}
