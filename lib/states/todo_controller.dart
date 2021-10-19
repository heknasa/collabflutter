import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/models/todo_model.dart';
import 'package:collabflutter/services/todo_repo.dart';

class TodoController extends StateNotifier<AsyncValue<List<TodoModel>>> {
  TodoController(this._read) : super(AsyncValue.loading()) {
    getTodo();
  }

  final Reader _read;

  static final todoControllerProvider = StateNotifierProvider.autoDispose<
      TodoController, AsyncValue<List<TodoModel>>>((ref) {
        return TodoController(ref.read);
    }
  );

  Future<void> addTodo(TodoModel todo) async {
    final _todoRepository = _read(TodoRepository.todoRepositoryProvider);
    final id = await _todoRepository.createTodo(todo);
    state.whenData((items) => state = AsyncValue.data(items..add(todo.copyWith(id: id))));
  }

  Future<void> getTodo() async {
    final _todoRepository = _read(TodoRepository.todoRepositoryProvider);
    final _todos = await _todoRepository.readTodo();
    state = AsyncValue.data(_todos);
  }

  Future<void> editTodo(TodoModel todo) async {
    final _todoRepository = _read(TodoRepository.todoRepositoryProvider);
    _todoRepository.updateTodo(todo);
    state.whenData((items) {
      state = AsyncValue.data([
        for (final item in items)
          if (item.id == todo.id) todo else item
      ]);
    });
  }

  Future<void> removeTodo(String id) async {
    final _todoRepository = _read(TodoRepository.todoRepositoryProvider);
    _todoRepository.deleteTodo(id);
    state.whenData((items) {
      items.removeWhere((item) => item.id == id);
      state = AsyncValue.data(items);
    });
  }
}