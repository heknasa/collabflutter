import 'package:collabflutter/providers/firebase_provider.dart';
import 'package:collabflutter/states/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/todo_model.dart';

abstract class BaseTodoRepository {
  Future<String> createTodo(TodoModel todo);
  Future<List<TodoModel>> readTodo();
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoRepository implements BaseTodoRepository {
  final Reader _read;

  TodoRepository(this._read);

  static final todoRepositoryProvider = Provider<TodoRepository>((ref) {
    return TodoRepository(ref.read);
  });

  @override
  Future<String> createTodo(TodoModel todo) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    final _todos = _firestore.collection('todos').doc(_uid).collection('todo');
    final _todo = await _todos.add(todo.toMap());
    return _todo.id;
  }

  @override
  Future<List<TodoModel>> readTodo() async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    final _todos = await _firestore.collection('todos').doc(_uid).collection('todo').orderBy('waktu', descending: true).get();
    return _todos.docs.map((x) => TodoModel.fromDocument(x)).toList();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    _firestore.collection('todos').doc(_uid).collection('todo').doc(todo.id).update(todo.toMap());
  }

  @override
  Future<void> deleteTodo(String id) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    _firestore.collection('todos').doc(_uid).collection('todo').doc(id).delete();
  }
}