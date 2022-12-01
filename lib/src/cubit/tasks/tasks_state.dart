part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksInitial extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksLoading extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksLoaded extends TasksState {
  final List<TaskModel> tasks;

 const TasksLoaded(this.tasks);
  @override
  List<Object> get props => [tasks];
}

class TasksLoadError extends TasksState {
  @override
  List<Object> get props => [];
}


class TasksUpdating extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksUpdated extends TasksState {
  @override
  List<Object> get props => [];
}
class TasksUpdateError extends TasksState {
  @override
  List<Object> get props => [];
}


class TasksCreating extends TasksState {
  @override
  List<Object> get props => [];
}


class TasksCreated extends TasksState {
  @override
  List<Object> get props => [];
}


class TasksCreateError extends TasksState {
  @override
  List<Object> get props => [];
}


class TasksDeleting extends TasksState {
  @override
  List<Object> get props => [];
}


class TasksDeleted extends TasksState {
  @override
  List<Object> get props => [];
}


class TasksDeleteError extends TasksState {
  @override
  List<Object> get props => [];
}