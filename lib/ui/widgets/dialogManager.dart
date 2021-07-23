
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:morphosis_flutter_demo/non_ui/modal/dialogModel.dart';
import 'package:morphosis_flutter_demo/services/dialogServices.dart';

import '../../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
    _dialogService.registerSnackListener(_snack);
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Text(request.title),
          content: Text(request.description),
          actions: <Widget>[
            if (isConfirmationDialog)
              TextButton(
                child: Text(request.cancelTitle),
                onPressed: () {
                  _dialogService
                      .dialogComplete(DialogResponse(confirmed: false));
                },
              ),
            TextButton(
              child: Text(request.buttonTitle),
              onPressed: () {
                _dialogService.dialogComplete(DialogResponse(confirmed: true));
              },
            ),
          ],
        ));
  }

  void _snack(DialogRequest request){
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor:  Colors.green,
      messageText: Text(
        request.description,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}