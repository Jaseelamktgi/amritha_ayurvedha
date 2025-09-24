import 'package:amritha_ayurvedha/core/api/api_paths.dart';
import 'package:amritha_ayurvedha/core/api/api_service.dart';
import 'package:amritha_ayurvedha/data/models/treatment_model.dart';

abstract class TreatmentRepository {
  Future<TreatmentResponse> fetchTreatments();
}

class TreatmentRepositoryImpl implements TreatmentRepository {
  final ApiService apiService;

  TreatmentRepositoryImpl({required this.apiService});

  @override
  Future<TreatmentResponse> fetchTreatments() async {
    try {
      final response = await apiService.get(ApiPaths.treatmentList);

      if (response.statusCode == 200) {
        return TreatmentResponse.fromJson(response.data);
      } else {
        return TreatmentResponse(
          status: false,
          message: "Failed to fetch treatments",
          treatments: [],
        );
      }
    } catch (e) {
      return TreatmentResponse(
        status: false,
        message: "Error: $e",
        treatments: [],
      );
    }
  }
}
