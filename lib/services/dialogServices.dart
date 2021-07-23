



import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:morphosis_flutter_demo/non_ui/modal/dialogModel.dart';

class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(DialogRequest) _showDialogListener;
  Function(DialogRequest) _showSnackListener;
  Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;


  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }


  void registerSnackListener(Function(DialogRequest) showSnack) {
    _showSnackListener = showSnack;
  }

  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));
    return _dialogCompleter.future;
  }


  Future<DialogResponse> showSnack({

    String description,

  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showSnackListener(DialogRequest(
    title: "",
      description: description,

    ));
    return _dialogCompleter.future;
  }



  Future<DialogResponse> showConfirmationDialog(
      {String title,
        String description,
        String confirmationTitle = 'Ok',
        String cancelTitle = 'Cancel'}) {
    _dialogCompleter = Completer<DialogResponse>();


    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle));
    return _dialogCompleter.future;
  }


  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}