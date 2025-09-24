import 'package:flutter/material.dart';
import 'package:amritha_ayurvedha/data/models/treatment_model.dart';
import 'package:amritha_ayurvedha/data/repositories/treatment_repository.dart';

class TreatmentProvider with ChangeNotifier {
  final TreatmentRepository repository;

  TreatmentProvider({required this.repository});

  bool _isLoading = false;
  List<Treatment> _treatments = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<Treatment> get treatments => _treatments;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTreatments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.fetchTreatments();

    if (result.status == true) {
      _treatments = result.treatments ?? [];
    } else {
      _treatments = [];
      _errorMessage = result.message;
    }

    _isLoading = false;
    notifyListeners();
  }
}
