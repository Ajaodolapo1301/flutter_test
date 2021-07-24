
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/constant.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/services/dialogServices.dart';
import 'package:morphosis_flutter_demo/services/navigationServices.dart';

import '../locator.dart';
import 'baseModel.dart';

class TaskViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final DialogService _dialogService = locator<DialogService>();

  List<Task> _task;
  List<Task> get tasks => _task;



  List<Task> get completeTasks => tasks?.where((todo) => todo.isCompleted)?.toList();


  void listenToPosts() {
    setBusy(true);
    FirebaseManager.shared.listenToTasktRealTime().listen((taskData) {
      print("uuuu$taskData");
      List<Task> updatedTasks = taskData;
      if (updatedTasks != null && updatedTasks.length > 0) {
        _task = updatedTasks;
          print("_dj$tasks");
        notifyListeners();
      }else{


      }

      setBusy(false);
    });
  }

  Future deletePost(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the task?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);

      await FirebaseManager.shared.deleteTask(_task[index].id);


      setBusy(false);
      await _dialogService.showSnack(color: Colors.green,
        description: 'Deleted',
      );
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(TaskFormRoute);
  }


}