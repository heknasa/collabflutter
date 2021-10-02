import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'authentication.dart';

class TodoDatabase extends ChangeNotifier {
  final dynamic todos = FirebaseFirestore.instance.collection('todos').doc(GoogleAuth().auth.currentUser?.uid).collection('todo');
  TodoDatabase({this.judulTodo, this.tanggalTodo, this.waktuTodo, this.kategoriTodo, this.deskripsiTodo});
  final String? judulTodo;
  final dynamic tanggalTodo;
  final dynamic waktuTodo;
  final String? kategoriTodo;
  final String? deskripsiTodo;

  Future createTodo() async {
    await todos.add({
      'judul': judulTodo,
      'tanggal': tanggalTodo,
      'waktu': waktuTodo,
      'kategori': kategoriTodo,
      'deskripsi': deskripsiTodo
    });
  }

  Future<QuerySnapshot> readTodo() {
    return todos.orderBy('waktu', descending: true).get();
  }

  Future updateTodo(String? todoID) async {
    await todos.doc(todoID).update({
      'judul': judulTodo ?? todos['judul'],
      'tanggal': tanggalTodo ?? todos['tanggal'],
      'waktu': waktuTodo ?? todos['waktu'],
      'kategori': kategoriTodo ?? todos['kategori'],
      'deskripsi': deskripsiTodo ?? todos['deskripsi']
    });
  }

  Future deleteTodo(String? idTodo) async {
    await todos.doc(idTodo).delete();
  }
}