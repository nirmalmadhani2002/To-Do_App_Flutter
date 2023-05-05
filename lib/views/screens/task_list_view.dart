import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/Models/task_model.dart';

import '../../controllers/Providers/ThemeProvider.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final _controller = TextEditingController();
  final _descriptionController = TextEditingController();

  int id = 0;

  final List<TaskModel> _tasks = [];

  void _addTask() {
    setState(() {
      final title = _controller.text;
      final description = _descriptionController.text;
      _tasks.add(TaskModel(title: title, description: description, id: id));
      _controller.clear();
      _descriptionController.clear();
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To-do List'),
        leading: IconButton(
          icon: const Icon(Icons.light_mode),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteTask(id),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all()
            ),
            child: TextField(
              controller: _controller,
              cursorColor: const Color(0XFF6A62B7),
              decoration: InputDecoration(
                  hintText: 'Enter task',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addTask,
                  ),
                  border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all()
            ),
            child: TextField(
              controller: _descriptionController,
              cursorColor: const Color(0XFF6A62B7),
              decoration: InputDecoration(
                hintText: 'Enter description',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return CheckboxListTile(
                  activeColor: Colors.red,
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  value: task.isDone,
                  onChanged: (value) => _toggleTask(index),
                  secondary: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
