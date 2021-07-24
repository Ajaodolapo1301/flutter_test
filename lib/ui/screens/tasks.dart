import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';
import 'package:morphosis_flutter_demo/viewModel/createAndEdit.dart';
import 'package:morphosis_flutter_demo/viewModel/taskViewModel.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatelessWidget {
  TasksPage({@required this.title, @required this.tasks});

  final String title;
  final List<Task> tasks;


  void addTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addTask(context),
          )
        ],
      ),
      body: tasks == null||  tasks.isEmpty
          ? Center(
              child: Text('Add your first task'),
            )
          : ListView.builder(

              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return _Task(
                  tasks[index],
                  index
                );
              },
            ),
    );
  }
}

class _Task extends StatefulWidget {
  _Task(this.task, this.index);

  final Task task;
  final int index;

  @override
  __TaskState createState() => __TaskState();
}

class __TaskState extends State<_Task> {

  TaskViewModel taskViewModel;
  CreateTaskViewModel createTaskViewModel;
  void _delete() async{
    //TODO implement delete to firestore
       taskViewModel.deletePost(widget.index).then((value){
         taskViewModel.tasks.removeAt(widget.index);
       });

  }

  void _toggleComplete() async{
    if( widget.task.isCompleted){
      widget.task.completedAt = null;
     await  createTaskViewModel.update( completedAt: null, title: widget.task.title, desc: widget.task.description, id: widget.task.id);

    }else{
      widget.task.completedAt = DateTime.now();
     await createTaskViewModel.update( completedAt: widget.task.isCompleted ? DateTime.now() : null, title: widget.task.title, desc: widget.task.description, id: widget.task.id);

    }

    //TODO implement toggle complete to firestore


  }



  void _view(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage(task: widget.task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    createTaskViewModel = Provider.of<CreateTaskViewModel>(context);
    taskViewModel = Provider.of<TaskViewModel>(context);
    return ListTile(
      leading: IconButton(
        icon: Icon(
          widget.task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onPressed: _toggleComplete,
      ),
      title: Text(widget.task.title),
      subtitle: Text(widget.task.description),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
        ),
        onPressed: _delete,
      ),
      onTap: () => _view(context),
    );
  }
}
