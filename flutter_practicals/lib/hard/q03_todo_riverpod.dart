import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RiverpodTodo {
  final String id;
  final String title;
  final bool isCompleted;

  const RiverpodTodo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  RiverpodTodo copyWith({String? title, bool? isCompleted}) {
    return RiverpodTodo(
      id: id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoListNotifier extends StateNotifier<List<RiverpodTodo>> {
  TodoListNotifier()
      : super([
          const RiverpodTodo(id: '1', title: 'Learn Flutter Riverpod StateNotifier'),
          const RiverpodTodo(id: '2', title: 'Implement StateNotifierProvider Todo'),
          const RiverpodTodo(id: '3', title: 'Prepare Practical Lab Submission'),
        ]);

  void add(String title) {
    state = [
      ...state,
      RiverpodTodo(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isCompleted: !todo.isCompleted) else todo,
    ];
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<RiverpodTodo>>((ref) {
  return TodoListNotifier();
});

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Q03TodoRiverpodScreen(),
      ),
    ),
  );
}

class Q03TodoRiverpodScreen extends ConsumerStatefulWidget {
  const Q03TodoRiverpodScreen({super.key});

  @override
  ConsumerState<Q03TodoRiverpodScreen> createState() => _Q03TodoRiverpodScreenState();
}

class _Q03TodoRiverpodScreenState extends ConsumerState<Q03TodoRiverpodScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      ref.read(todoListProvider.notifier).add(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard Q3: Riverpod StateNotifierProvider'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Add new Riverpod todo...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: _submit,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: todos.isEmpty
                ? const Center(child: Text('No tasks found.'))
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) {
                              ref.read(todoListProvider.notifier).toggle(todo.id);
                            },
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                              color: todo.isCompleted ? Colors.grey : Colors.black87,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              ref.read(todoListProvider.notifier).remove(todo.id);
                            },
                          ),
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
