import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_task_firebase_june_ndz/src/cubit/tasks/tasks_cubit.dart';
import 'package:my_task_firebase_june_ndz/src/models/task_model.dart';

class EditTaskPage extends StatefulWidget {
 final TaskModel taskModel;
  const EditTaskPage({required this.taskModel,Key? key}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    _titleController.text = widget.taskModel.title;
    _descriptionController.text = widget.taskModel.description;
    _startDateController.text = widget.taskModel.startDate.toString();
    _endDateController.text = widget.taskModel.endDate.toString();
    super.initState();
  }
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
              onChanged: (inputText){
                widget.taskModel.title = inputText;
              },
              decoration: InputDecoration(
                  labelText: "Title"
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              onChanged: (inputText){
                widget.taskModel.description = inputText;
              },
              decoration: InputDecoration(
                  labelText: "Description"
              ),
            ),
            TextFormField(
              controller: _startDateController,
              readOnly: true,
              onTap: () async {
                DateTime? startTimeTemp = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime.now(), lastDate: DateTime(2030)
                );
                if (startTimeTemp  != null) {
                  _startDateController.text = startTimeTemp.toString();
                  widget.taskModel.startDate = startTimeTemp;
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
                DateTime? endTimeTemp  = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime.now(), lastDate: DateTime(2030)
                );
                if (endTimeTemp != null) {
                  _endDateController.text = endTimeTemp.toString();
                  widget.taskModel.endDate = endTimeTemp;
                }
              },
              decoration: InputDecoration(
                  labelText: "End Date"
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Is Completed"),
                Switch(value: widget.taskModel.isCompleted, onChanged: (changedStatus){
                  setState(() {
                    widget.taskModel.isCompleted = changedStatus;
                  });
                })
              ],
            ),
            BlocConsumer<TasksCubit, TasksState>(
              listener: (context, state) {
                if(state is TasksUpdated){
                  Navigator.pop(context);
                }else if(state is TasksUpdateError){
                  Fluttertoast.showToast(
                      msg: "Error updating the task",
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
                if(state is TasksUpdating){
                  return CircularProgressIndicator();
                }
                return ElevatedButton(onPressed: () {
                  context.read<TasksCubit>().updateTasks(widget.taskModel);
                }, child: Text("Update Task"));
              },
            )
          ],
        ),
        ),
      ),
    );
  }
}
