import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<TodoModel> todoFromJson(String str) => List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromMap(x)));

String todoToJson(List<TodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TodoModel {
  String? id, judul, kategori, deskripsi;
  Timestamp? tanggal, waktu;

  TodoModel({
    this.id,
    this.judul,
    this.tanggal,
    this.waktu,
    this.kategori,
    this.deskripsi
  });

  factory TodoModel.empty() => TodoModel(
    judul: null,
    tanggal: null,
    waktu: null,
    kategori: null,
    deskripsi: null
  );

  TodoModel copyWith({String? id, String? judul, Timestamp? tanggal, Timestamp? waktu, String? kategori, String? deskripsi}) {
    return TodoModel(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      tanggal: tanggal ?? this.tanggal,
      waktu: waktu ?? this.waktu,
      kategori: kategori?? this.kategori,
      deskripsi: deskripsi ?? this.deskripsi
    );
  }

  factory TodoModel.fromMap(Map<String, dynamic> json) => TodoModel(
    id: json['id'],
    judul: json['judul'],
    tanggal: json['tanggal'],
    waktu: json['waktu'],
    kategori: json['kategori'],
    deskripsi: json['deskripsi']
  );

  Map<String, dynamic> toMap() => {
    'judul': judul,
    'tanggal': tanggal,
    'waktu': waktu,
    'kategori': kategori,
    'deskripsi': deskripsi,
  };

  factory TodoModel.fromDocument(QueryDocumentSnapshot doc) => TodoModel(
    id: doc.id,
    judul: doc.get('judul'),
    tanggal: doc.get('tanggal'),
    waktu: doc.get('waktu'),
    kategori: doc.get('kategori'),
    deskripsi: doc.get('deskripsi'),
  );
}