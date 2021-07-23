

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:morphosis_flutter_demo/constants/color_utils.dart';







class MyUtils {

 static formatDate(String date) {
    if (date == null) {
      return date ?? "";
    }

    var fmtDate = DateFormat.yMMMd().format(DateTime.parse(date));
//    String fmtDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    String fmtTime =DateFormat('kk:mm:a').format(DateTime.parse(date));
    return "${fmtDate.toString()} - ${fmtTime.toString()}";
  }
 static cupertinoDark({@required BuildContext context}) {
   return CupertinoTheme(
     data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
     child: CupertinoActivityIndicator(),
   );
 }
 static  kShowSnackBar({BuildContext ctx, String msg, Color color  }) {
   return Flushbar(
     flushbarPosition: FlushbarPosition.BOTTOM,
     backgroundColor:  color ?? blue,
     messageText: Text(
       msg,
       textAlign: TextAlign.center,
       style: TextStyle(
         color: Colors.white,
         fontSize: 15,
       ),
     ),
     duration: Duration(seconds: 2),
   )..show(ctx);




 }











}








