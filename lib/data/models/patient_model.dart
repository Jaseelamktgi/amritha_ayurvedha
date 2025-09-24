
import 'dart:convert';
/// -------------------- Branch (Shared) --------------------
class Branch {
  int? id;
  String? name;
  int? patientsCount;
  String? location;
  String? phone;
  String? mail;
  String? address;
  String? gst;
  bool? isActive;

  Branch({
    this.id,
    this.name,
    this.patientsCount,
    this.location,
    this.phone,
    this.mail,
    this.address,
    this.gst,
    this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'] as int?,
        name: json['name'] as String?,
        patientsCount: json['patients_count'] as int?,
        location: json['location'] as String?,
        phone: json['phone'] as String?,
        mail: json['mail'] as String?,
        address: json['address'] as String?,
        gst: json['gst'] as String?,
        isActive: json['is_active'] as bool?,
      );


}

/// -------------------- Patient Models --------------------
PatientResponse patientResponseFromJson(String str) =>
    PatientResponse.fromJson(json.decode(str));

class PatientResponse {
  bool? status;
  String? message;
  List<Patient>? patients;

  PatientResponse({this.status, this.message, this.patients});

  factory PatientResponse.fromJson(Map<String, dynamic> json) => PatientResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        patients: json["patient"] == null
            ? []
            : List<Patient>.from(
                json["patient"].map((x) => Patient.fromJson(x)),
              ),
      );
}

class Patient {
  int? id;
  List<PatientDetails>? patientDetails;
  Branch? branch;
  String? user;
  String? payment;
  String? name;
  String? phone;
  String? address;
  dynamic price;
  num? totalAmount;
  num? discountAmount;
  num? advanceAmount;
  num? balanceAmount;
  String? dateNdTime;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Patient({
    this.id,
    this.patientDetails,
    this.branch,
    this.user,
    this.payment,
    this.name,
    this.phone,
    this.address,
    this.price,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateNdTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"] ?? 0,
        patientDetails: json["patientdetails_set"] == null
            ? []
            : List<PatientDetails>.from(
                json["patientdetails_set"].map((x) => PatientDetails.fromJson(x)),
              ),
        branch: json["branch"] != null ? Branch.fromJson(json["branch"]) : null,
        user: json["user"],
        payment: json["payment"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        price: json["price"],
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        advanceAmount: json["advance_amount"],
        balanceAmount: json["balance_amount"],
        dateNdTime: json["date_nd_time"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class PatientDetails {
  int? id;
  dynamic male;
  dynamic female;
  int? patient;
  int? treatment;
  String? treatmentName;

  PatientDetails({
    this.id,
    this.male,
    this.female,
    this.patient,
    this.treatment,
    this.treatmentName,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) => PatientDetails(
        id: json["id"] ?? 0,
        male: json["male"],
        female: json["female"],
        patient: json["patient"] ?? 0,
        treatment: json["treatment"],
        treatmentName: json["treatment_name"],
      );
}