import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import 'package:morphosis_flutter_demo/ui/screens/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/tasks.dart';

import 'package:morphosis_flutter_demo/viewModel/taskViewModel.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with AfterLayoutMixin<IndexPage> {
  int _currentIndex = 0;
  TaskViewModel taskViewModel;


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    taskViewModel = Provider.of<TaskViewModel>(context);

    List<Widget> children = [
      HomePage(),
      TasksPage(
        title: 'All Tasks',
        tasks: taskViewModel?.tasks,
      ),
      TasksPage(
        title: 'Completed Tasks',
        tasks: taskViewModel?.completeTasks,
      )
    ];

    return Scaffold(
      body: children [_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    taskViewModel.listenToPosts();

  }
}
