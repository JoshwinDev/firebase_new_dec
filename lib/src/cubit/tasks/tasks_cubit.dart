import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:my_task_firebase_june_ndz/src/cubit/tasks/tasks_repository.dart';
import 'package:my_task_firebase_june_ndz/src/models/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksRepository _repository =TasksRepository();
  TasksCubit() : super(TasksInitial());

  createTasks(TaskModel taskModel) async{
    emit(TasksCreating());
    try{
    _repository.createTasks(taskModel);
    emit(TasksCreated());
    await Future.delayed(Duration(seconds: 1));
    getAllTasks();
  }catch(ex){
    emit(TasksCreateError());
  }
}
  updateTasks(TaskModel taskModel) async{
    emit(TasksUpdating());
    try{
      _repository.createTasks(taskModel);
      emit(TasksUpdated());
      await Future.delayed(Duration(seconds: 1));
      getAllTasks();
    }catch(ex){
      emit(TasksUpdateError());
    }
  }
  deleteTasks(TaskModel taskModel) async{
    emit(TasksDeleting());
    try{
      _repository.createTasks(taskModel);
      emit(TasksDeleted());
      await Future.delayed(Duration(seconds: 1));
      getAllTasks();
    }catch(ex){
      emit(TasksDeleteError());
    }
  }

  getAllTasks() async {
    emit(TasksLoading());
    try{
      QuerySnapshot snapshot = await _repository.getTasks();
      List<TaskModel> taskList = snapshot.docs.map((e){
        Map<String,dynamic> dx = e.data() as Map<String,dynamic>;
        String id = e.id;
        TaskModel taskModel = TaskModel.fromJson(dx);
        taskModel.id = id;
        return taskModel;
      }).toList();
      emit(TasksLoaded(taskList));
    }catch(ex){
      emit(TasksLoadError());
    }
  }
  }
