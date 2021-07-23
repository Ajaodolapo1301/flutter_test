

import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/ui/screens/index.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';


import 'constants/constant.dart';
import 'non_ui/modal/task.dart';



Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {


    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: IndexPage(),
      );
    case TaskFormRoute:
      var postToEdit = settings.arguments as Task;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: TaskPage(task: postToEdit,),
      );


    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}')),
          ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}