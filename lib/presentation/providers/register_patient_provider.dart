import 'package:amritha_ayurvedha/core/pdf_service.dart';
import 'package:amritha_ayurvedha/data/models/patient_model.dart';
import 'package:amritha_ayurvedha/data/repositories/register_patient_repository.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class RegisterPatientProvider with ChangeNotifier {
  final RegisterPatientRepository repository;

  List<Branch> branches = [];
  Branch? selectedBranch;
  String? selectedLocation;
  String selectedPayment = 'Card';

  RegisterPatientProvider({required this.repository});

  Future<void> fetchBranches() async {
    branches = await repository.fetchBranches();
    notifyListeners();
  }

  void setSelectedBranch(Branch branch) {
    selectedBranch = branch;
    notifyListeners();
  }

  void setSelectedLocation(String location) {
    selectedLocation = location;
    notifyListeners();
  }

  void setSelectedPayment(String payment) {
    selectedPayment = payment;
    notifyListeners();
  }

  Future<bool> submitPatient({
    required String name,
    required String phone,
    required String address,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    required String dateNdTime,
    required String male,
    required String female,
    required String treatments,
  }) async {
    if (selectedBranch == null || selectedLocation == null) return false;

    final DateTime now = DateTime.now();
    final formattedDate =
        "$dateNdTime-${now.hour}:${now.minute} ${now.hour >= 12 ? 'PM' : 'AM'}";

    final success = await repository.registerPatient(
      name: name,
      excecutive: "Admin",
      payment: selectedPayment,
      phone: phone,
      address: address,
      totalAmount: totalAmount,
      discountAmount: discountAmount,
      advanceAmount: advanceAmount,
      balanceAmount: balanceAmount,
      dateNdTime: formattedDate,
      id: "",
      male: male,
      female: female,
      branch: selectedBranch!.id.toString(),
      treatments: treatments,
    );

    if (success) {
      final pdfFile = await PdfGenerator.generatePatientPdf(
        name: name,
        address: address,
        phone: phone,
        bookedOn:
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} | ${now.hour}:${now.minute}${now.hour >= 12 ? 'PM' : 'AM'}",
        treatmentDate: dateNdTime.split('-').first,
        treatmentTime: dateNdTime.split('-').last,
        treatments: [
          {
            "treatment": "Panchakarma",
            "price": 230,
            "male": 4,
            "female": 4,
            "total": 2540,
          },
          {
            "treatment": "Njavara Kizhi Treatment",
            "price": 230,
            "male": 4,
            "female": 4,
            "total": 2540,
          },
        ],
        totalAmount: totalAmount,
        discount: discountAmount,
        advance: advanceAmount,
        balance: balanceAmount,
      );

      await Printing.layoutPdf(
        onLayout: (format) async => pdfFile.readAsBytesSync(),
      );
    }

    return success;
  }
}
