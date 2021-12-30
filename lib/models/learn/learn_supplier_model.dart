import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<LearnSupplierModel> learnInternFromJson(String str) {
  return List<LearnSupplierModel>.from(json.decode(str).map((x) => LearnSupplierModel.fromMap(x)));
}

String learnInternToJson(List<LearnSupplierModel> data) {
  return json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}

class LearnSupplierModel {   
  // worksheetTitle make default 'Sheet1' aja
  String spreadsheetID;
  String judul;
  String thumbnail;
  String pemateri;
  String posisi;
  String perusahaan;  
  Timestamp? tanggal, waktu;
  String profilPemateri;
  String paymentLink;
  String? remindLink;
  String? joinLink;
  String? watchLink;

  LearnSupplierModel({
    this.id,
    this.judul,
    this.tanggal,
    this.waktu,
    this.kategori,
    this.deskripsi
  });

  factory LearnSupplierModel.fromMap(Map<String, dynamic> json) => LearnSupplierModel(
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

  factory LearnSupplierModel.fromDocument(QueryDocumentSnapshot doc) => LearnSupplierModel(
    id: doc.id,
    judul: doc.get('judul'),
    tanggal: doc.get('tanggal'),
    waktu: doc.get('waktu'),
    kategori: doc.get('kategori'),
    deskripsi: doc.get('deskripsi'),
  );
}