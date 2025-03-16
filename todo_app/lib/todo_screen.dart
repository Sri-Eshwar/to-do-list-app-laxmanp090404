import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({'text': _taskController.text.trim(), 'completed': false});
        _taskController.clear();
      });
    }
  }

  void _toggleTask(int index, bool? isChecked) {
    if (isChecked != null) {
      setState(() {
        _tasks[index]['completed'] = isChecked;
      });
    }
  }

  void _removeTask(int index) {
    setState(() => _tasks.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'Enter a new task...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('No tasks added!'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: Checkbox(
                          value: _tasks[index]['completed'],
                          onChanged: (isChecked) => _toggleTask(index, isChecked),
                        ),
                        title: Text(
                          _tasks[index]['text'],
                          style: TextStyle(
                            decoration: _tasks[index]['completed']
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeTask(index),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
