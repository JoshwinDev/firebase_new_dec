
class TaskModel{
  // title,description,startDate,endDate,isCompleted
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool isCompleted;
  String? id;


  TaskModel({required this.title, required this.description,required this.startDate, required this.endDate,
    required this.isCompleted});


  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json["title"],
      description: json["description"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      isCompleted: json["isCompleted"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "description": this.description,
      "startDate": this.startDate.toIso8601String(),
      "endDate": this.endDate.toIso8601String(),
      "isCompleted": this.isCompleted,
    };
  }
}