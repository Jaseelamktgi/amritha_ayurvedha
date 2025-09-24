import 'dart:convert';

import 'package:amritha_ayurvedha/data/models/patient_model.dart';

TreatmentResponse treatmentResponseFromJson(String str) =>
    TreatmentResponse.fromJson(json.decode(str));

class TreatmentResponse {
  bool? status;
  String? message;
  List<Treatment>? treatments;

  TreatmentResponse({this.status, this.message, this.treatments});

  factory TreatmentResponse.fromJson(Map<String, dynamic> json) =>
      TreatmentResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        treatments: (json['treatments'] as List<dynamic>?)
            ?.map((e) => Treatment.fromJson(e))
            .toList(),
      );
}

class Treatment {
  int? id;
  List<Branch>? branches;
  String? name;
  String? duration;
  int? price;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Treatment({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    id: json['id'] as int?,
    branches: (json['branches'] as List<dynamic>?)
        ?.map((e) => Branch.fromJson(e))
        .toList(),
    name: json['name'] as String?,
    duration: json['duration'] as String?,
    price: json['price'] is int
        ? json['price']
        : int.tryParse(json['price'].toString()),
    isActive: json['is_active'] as bool?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );
}
