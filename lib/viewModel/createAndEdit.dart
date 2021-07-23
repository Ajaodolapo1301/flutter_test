
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/services/dialogServices.dart';
import 'package:morphosis_flutter_demo/services/navigationServices.dart';

import '../locator.dart';
import 'baseModel.dart';

class CreateTaskViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Task _editingTask;

  bool get _editting => _editingTask != null ;

  Future addPost({String title, String desc, id, completedAt}) async {
    setBusy(true);

    var result;

    result = await FirebaseManager.shared.addTask(Task(
        title: title,
        description: desc,
        id: null,
        completedAt: completedAt ?? null));

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Task successfully ${_editting ? "Updated" : "Added"} ',
        description: 'Your task has been ${_editting ? "updated" : "created"}',
      );
    }

    _navigationService.pop();
  }

  Future update({String title, String desc, id, completedAt}) async {
    setBusy(true);

    var result;
    result = await FirebaseManager.shared.updateTask(
        Task(
            title: title,
            description: desc,
            id: "",
            completedAt: completedAt ?? null),
        id);

    setBusy(false);
    print(result);

    if (result is String) {
      await _dialogService.showSnack(
        description: "An error occured",
      );
    } else {
      await _dialogService.showSnack(
        description: 'Your task has been updated',
      );
    }

    _navigationService.pop();
  }
}
