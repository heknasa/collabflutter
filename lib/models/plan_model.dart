import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<PlanModel> planFromJson(String str) => List<PlanModel>.from(json.decode(str).map((x) => PlanModel.fromMap(x)));

String planToJson(List<PlanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PlanModel {
  String? id, agenda;
  Timestamp? tanggal, waktu;

  PlanModel({
    this.id,
    this.agenda,
    this.tanggal,
    this.waktu,
  });

  factory PlanModel.empty() => PlanModel(
    agenda: null,
    tanggal: null,
    waktu: null,
  );

  PlanModel copyWith({String? id, String? agenda, Timestamp? tanggal, Timestamp? waktu}) {
    return PlanModel(
      id: id ?? this.id,
      agenda: agenda ?? this.agenda,
      tanggal: tanggal ?? this.tanggal,
      waktu: waktu ?? this.waktu
    );
  }

  factory PlanModel.fromMap(Map<String, dynamic> json) => PlanModel(
    id: json['id'],
    agenda: json['agenda'],
    tanggal: json['tanggal'],
    waktu: json['waktu'],
  );

  Map<String, dynamic> toMap() => {
    'agenda': agenda,
    'tanggal': tanggal,
    'waktu': waktu,
  };

  factory PlanModel.fromDocument(QueryDocumentSnapshot doc) => PlanModel(
    id: doc.id,
    agenda: doc.get('agenda'),
    tanggal: doc.get('tanggal'),
    waktu: doc.get('waktu'),
  );
}