import 'package:amritha_ayurvedha/core/api/api_paths.dart';
import 'package:amritha_ayurvedha/core/api/api_service.dart';
import 'package:amritha_ayurvedha/data/models/patient_model.dart';

abstract class RegisterPatientRepository {
  Future<List<Branch>> fetchBranches();
  Future<bool> registerPatient({
    required String name,
    required String excecutive,
    required String payment,
    required String phone,
    required String address,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    required String dateNdTime,
    required String id,
    required String male,
    required String female,
    required String branch,
    required String treatments,
  });
}

class RegisterPatientRepositoryImpl implements RegisterPatientRepository {
  final ApiService apiService;

  RegisterPatientRepositoryImpl({required this.apiService});

  @override
  Future<List<Branch>> fetchBranches() async {
    try {
      final response = await apiService.get(ApiPaths.branchList);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['branches'] ?? [];
        return data.map((e) => Branch.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> registerPatient({
    required String name,
    required String excecutive,
    required String payment,
    required String phone,
    required String address,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    required String dateNdTime,
    required String id,
    required String male,
    required String female,
    required String branch,
    required String treatments,
  }) async {
    try {
      final body = {
        "name": name,
        "excecutive": excecutive,
        "payment": payment,
        "phone": phone,
        "address": address,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "advance_amount": advanceAmount,
        "balance_amount": balanceAmount,
        "date_nd_time": dateNdTime,
        "id": id,
        "male": male,
        "female": female,
        "branch": branch,
        "treatments": treatments,
      };

      final response = await apiService.post(
        ApiPaths.patientUpdate,
        body,
        asFormData: false,
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error registering patient: $e");
      return false;
    }
  }
}
