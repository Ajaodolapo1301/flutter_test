import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/myUtils.dart';

import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';

import 'package:morphosis_flutter_demo/viewModel/createAndEdit.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit Task'),
      ),
      body: _TaskForm(task),
    );
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task);

  final Task task;
  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);
  final _formKey = GlobalKey<FormState>();
  Task task;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  CreateTaskViewModel createTaskViewModel;
  void init() {
    if (task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: task.title);
      _descriptionController = TextEditingController(text: task.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    task.isNew ? add() : update();
  }

  @override
  Widget build(BuildContext context) {
    createTaskViewModel = Provider.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Form(
          key: _formKey ,
          child: Column(
            children: [
              TextFormField(
                validator: (v){
                if(v.isEmpty){
                  return "Field required";
                }

                return null;
              },
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: _padding),
              TextFormField(
                validator: (v){
                  if(v.isEmpty){
                    return "Field required";
                  }

                  return null;
                },
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                minLines: 5,
                maxLines: 10,
              ),
              SizedBox(height: _padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Completed ?'),
                  CupertinoSwitch(
                    value: task.isCompleted,
                    onChanged: (_) {
                      setState(() {
                        task.toggleComplete();
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    _save(context);
                  }else{
                    MyUtils.kShowSnackBar(msg: "Fill all forms", color: Colors.red, ctx: context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                      child: createTaskViewModel.busy
                          ? MyUtils.cupertinoDark(context: context)
                          : Text(task.isNew ? 'Create' : 'Update')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  add() async {
    createTaskViewModel.addPost(
        title: _titleController.text,
        desc: _descriptionController.text,
        id: null,
        completedAt: task.isCompleted ? DateTime.now() : null);
  }

  update() async {
    createTaskViewModel.update(
        title: _titleController.text,
        desc: _descriptionController.text,
        id: task?.id,
        completedAt: task.isCompleted ? DateTime.now() : null);

    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.maybePop(context);
    });
  }
}
