import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 4:
/// Build a StatefulWidget-based to-do list app where each item can be added,
/// marked complete (using setState), and removed, ensuring proper use of
/// didUpdateWidget when the list is passed from a parent widget.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoParentHostScreen(),
  ));
}

class TodoModel {
  final String id;
  String text;
  bool isCompleted;

  TodoModel({required this.id, required this.text, this.isCompleted = false});
}

// ================= PARENT WIDGET =================
class TodoParentHostScreen extends StatefulWidget {
  const TodoParentHostScreen({super.key});

  @override
  State<TodoParentHostScreen> createState() => _TodoParentHostScreenState();
}

class _TodoParentHostScreenState extends State<TodoParentHostScreen> {
  // Parent maintains presets / external batches
  List<TodoModel> _parentSuppliedTodos = [
    TodoModel(id: '1', text: 'Revise Dart OOP & Polymorphism'),
    TodoModel(id: '2', text: 'Master Flutter State Management'),
  ];

  int _batchCounter = 1;

  void _injectNewBatchFromParent() {
    _batchCounter++;
    setState(() {
      _parentSuppliedTodos = [
        TodoModel(id: '$_batchCounter-1', text: 'Lab Practical Batch $_batchCounter - Task A'),
        TodoModel(id: '$_batchCounter-2', text: 'Lab Practical Batch $_batchCounter - Task B'),
        TodoModel(id: '$_batchCounter-3', text: 'Lab Practical Batch $_batchCounter - Task C'),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section C Q4: didUpdateWidget Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Inject new list from parent',
            icon: const Icon(Icons.sync),
            onPressed: _injectNewBatchFromParent,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.amber.shade50,
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.amber),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Parent Widget passes list to child. Tap top-right refresh to trigger didUpdateWidget() in child!',
                    style: TextStyle(fontSize: 12, color: Colors.brown),
                  ),
                ),
                TextButton(
                  onPressed: _injectNewBatchFromParent,
                  child: const Text('Send Batch'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TodoChildListWidget(parentTodos: _parentSuppliedTodos),
          ),
        ],
      ),
    );
  }
}

// ================= CHILD STATEFUL WIDGET USING didUpdateWidget =================
class TodoChildListWidget extends StatefulWidget {
  final List<TodoModel> parentTodos;

  const TodoChildListWidget({super.key, required this.parentTodos});

  @override
  State<TodoChildListWidget> createState() => _TodoChildListWidgetState();
}

class _TodoChildListWidgetState extends State<TodoChildListWidget> {
  late List<TodoModel> _localTodos;
  final TextEditingController _inputController = TextEditingController();
  String _lifecycleMessage = 'Initialized via initState()';

  @override
  void initState() {
    super.initState();
    // Copy the list passed by parent into local state
    _localTodos = List.from(widget.parentTodos);
  }

  // Proper implementation of didUpdateWidget
  @override
  void didUpdateWidget(covariant TodoChildListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If parent widget re-built with a different list instance, sync state
    if (oldWidget.parentTodos != widget.parentTodos) {
      setState(() {
        _localTodos = List.from(widget.parentTodos);
        _lifecycleMessage = 'didUpdateWidget() detected new list from parent at ${DateTime.now().toIso8601String().substring(11, 19)}!';
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _addItem() {
    final text = _inputController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _localTodos.add(TodoModel(id: DateTime.now().millisecondsSinceEpoch.toString(), text: text));
        _inputController.clear();
      });
    }
  }

  void _toggleItem(int index) {
    setState(() {
      _localTodos[index].isCompleted = !_localTodos[index].isCompleted;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _localTodos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // State update notification banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.indigo.shade50,
          child: Text(
            'Child Status: $_lifecycleMessage',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
        ),
        // Add new item input
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inputController,
                  decoration: const InputDecoration(
                    labelText: 'Add child item',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _addItem(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                onPressed: _addItem,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
        // List of items
        Expanded(
          child: _localTodos.isEmpty
              ? const Center(child: Text('No tasks available.'))
              : ListView.builder(
                  itemCount: _localTodos.length,
                  itemBuilder: (context, index) {
                    final item = _localTodos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: Checkbox(
                          value: item.isCompleted,
                          onChanged: (_) => _toggleItem(index),
                        ),
                        title: Text(
                          item.text,
                          style: TextStyle(
                            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                            color: item.isCompleted ? Colors.grey : Colors.black87,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _removeItem(index),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
