import 'package:collabflutter/providers/firebase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/todo_model.dart';

// final CollectionReference todos = FirebaseFirestore.instance.collection('todos').doc(GoogleAuth().auth.currentUser?.uid).collection('todo');

abstract class BaseTodoRepository {
  Future<String> createTodo(TodoModel todo);
  Future<List<TodoModel>> readTodo();
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoRepository {  
  final Reader _read;

  TodoRepository(this._read);

  static final todoRepositoryProvider = Provider<TodoRepository>((ref) {
    return TodoRepository(ref.read);
  });

  Future<String> createTodo(TodoModel todo) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _todos = _firestore.collection('todos').doc('authid').collection('todo');
    final _todo = await _todos.add(todo.toMap());
    return _todo.id;
  }

  Future<List<TodoModel>> readTodo() async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _todos = await _firestore.collection('todos').doc('authid').collection('todo').orderBy('waktu', descending: true).get();
    return _todos.docs.map((x) => TodoModel.fromDocument(x)).toList();
  }

  Future<void> updateTodo(TodoModel todo) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    _firestore.collection('todos').doc('authid').collection('todo').doc(todo.id).update(todo.toMap());
  }

  Future<void> deleteTodo(String id) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    _firestore.collection('todos').doc('authid').collection('todo').doc(id).delete();
  }
}