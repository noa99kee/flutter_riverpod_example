import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  String id;
  String description;
  bool completed;
}

//ChangeNotifier 가변 상태(객체) 노출
class TodosNotifier extends ChangeNotifier {
  final todos = <Todo>[
    Todo(id: '0', description: '쁘미 밥 주기', completed: false),
    Todo(id: '1', description: '또리 물 주기', completed: false),
    Todo(id: '2', description: '깜봉이 놀아 주기', completed: false),
  ];

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  // Let's allow removing todos
  void removeTodo(String todoId) {
    todos.remove(todos.firstWhere((element) => element.id == todoId));
    notifyListeners();
  }

  // Let's mark a todo as completed
  void toggle(String todoId) {
    for (final todo in todos) {
      if (todo.id == todoId) {
        todo.completed = !todo.completed;
        notifyListeners();
      }
    }
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final todosProvider = ChangeNotifierProvider.autoDispose<TodosNotifier>((ref) {
  return TodosNotifier();
});

class ChangeNotifierProviderWidget extends ConsumerWidget {
  const ChangeNotifierProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // rebuild the widget when the todo list changes
    List<Todo> todos = ref.watch(todosProvider).todos;

    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifierProvider')),
      body: ListView(
        shrinkWrap: true,
        children: [
          for (final todo in todos)
            CheckboxListTile(
              value: todo.completed,
              // When tapping on the todo, change its completed status
              onChanged: (value) =>
                  ref.read(todosProvider.notifier).toggle(todo.id),
              title: Text(todo.description),
            ),
        ],
      ),
    );
  }
}
