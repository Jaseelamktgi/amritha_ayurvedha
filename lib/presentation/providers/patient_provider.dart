import 'package:amritha_ayurvedha/data/models/patient_model.dart';
import 'package:amritha_ayurvedha/data/repositories/patient_repository.dart';
import 'package:flutter/material.dart';

class PatientProvider with ChangeNotifier {
  final PatientRepository repository;

  PatientProvider({required this.repository});

  bool _isLoading = false;
  List<Patient> _patients = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<Patient> get patients => _patients;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPatients() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.fetchPatients();

    if (result.status == true) {
      _patients = result.patients ?? [];
    } else {
      _patients = [];
      _errorMessage = result.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Clears and reloads patient list
  Future<void> refreshPatients() async {
    _patients = [];
    notifyListeners();
    await fetchPatients();
  }
}
