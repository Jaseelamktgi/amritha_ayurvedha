import 'package:amritha_ayurvedha/core/api/api_paths.dart';
import 'package:amritha_ayurvedha/core/api/api_service.dart';
import 'package:amritha_ayurvedha/data/models/patient_model.dart';

abstract class PatientRepository {
  Future<PatientResponse> fetchPatients();
}

class PatientRepositoryImpl implements PatientRepository {
  final ApiService apiService;

  PatientRepositoryImpl({required this.apiService});

  @override
  Future<PatientResponse> fetchPatients() async {
    try {
      final response = await apiService.get(ApiPaths.patientList);

      if (response.statusCode == 200) {
        return PatientResponse.fromJson(response.data);
      } else {
        return PatientResponse(
          status: false,
          message: "Failed to fetch patients",
          patients: [],
        );
      }
    } catch (e) {
      return PatientResponse(status: false, message: "Error: $e", patients: []);
    }
  }
}
