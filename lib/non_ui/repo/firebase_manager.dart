import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';

class FirebaseManager {
  static FirebaseManager _one;

  static FirebaseManager get shared =>
      (_one == null ? (_one = FirebaseManager._()) : _one);
  FirebaseManager._();

  Future<void> initialise() => Firebase.initializeApp();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  //TODO: change collection name to something unique or your name
  CollectionReference get tasksRef => FirebaseFirestore.instance.collection('ajao');

  //TODO: replace mock data. Remember to set the task id to the firebase object id
  // List<Task> get tasks => mockData.map((t) => Task.fromJson(t)).toList();


  final StreamController<List<Task>> _tasksController = StreamController<List<Task>>.broadcast();
  //TODO: implement firestore CRUD functions here


  // Adding a single task
  Future addTask(Task task) async {
    try {
      print(task.toJson());
      await tasksRef.add(task.toJson());


    } catch (e) {

      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }


  Stream listenToTasktRealTime() {

    tasksRef.snapshots().listen((tasksSnapshot) {
      if (tasksSnapshot.docs.isNotEmpty) {
        var tasks = tasksSnapshot.docs
            .map((snapshot) =>
            Task.fromMap(snapshot: snapshot.data(), taskID: snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();


        _tasksController.add(tasks);
      }
    });

    // Return the stream underlying our _postsController.
    return _tasksController.stream;
  }

  Future deleteTask(String documentId) async {
    await tasksRef.doc(documentId).delete();
  }


  Future updateTask(Task task, String id) async {
    try {
      await tasksRef.doc(id).update(task.toJson());
    } catch (e) {

      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }




}









// List<Map<String, dynamic>> mockData = [
//   {"id": "1", "title": "Task 1", "description": "Task 1 description"},
//   {
//     "id": "2",
//     "title": "Task 2",
//     "description": "Task 2 description",
//     "completed_at": DateTime.now().toIso8601String()
//   }
// ];
