import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'task.g.dart';

// @JsonSerializable(explicitToJson: true)
class Task {
  Task({this.id, this.completedAt, this.title, this.description});

  String id;
  String title;
  String description;
  // @JsonKey(name: 'completed_at')
  DateTime completedAt;

  bool get isNew {
    return id == null;
  }

  bool get isCompleted {
    return completedAt != null;
  }

  void toggleComplete() {
    if (isCompleted) {
      completedAt = null;
    } else {
      completedAt = DateTime.now();
    }
  }




  Task.fromMap({Map snapshot, String taskID}){

    // print(id);
    id = taskID ?? "";
    title = snapshot['title'] ?? '';
    description = snapshot['description'] ?? '';
    completedAt = snapshot['completed_at'] == null ? null :
    formatTimestamp(snapshot['completed_at']);
  }



  toJson() {

    return {
      'completed_at': completedAt,
      "description": description,
      "title": title,
      "id" : id
    };
  }


  formatTimestamp(Timestamp timestamp) {
    Timestamp t = timestamp;
    DateTime d = t.toDate();
    return d;
  }
//
// factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
//
// Map<String, dynamic> toJson() => _$TaskToJson(this);
}
