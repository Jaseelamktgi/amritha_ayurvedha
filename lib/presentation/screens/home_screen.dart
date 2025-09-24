import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:amritha_ayurvedha/core/extensions/margin_extn.dart';
import 'package:amritha_ayurvedha/presentation/screens/treatment_screen.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:amritha_ayurvedha/presentation/providers/patient_provider.dart';
import 'package:amritha_ayurvedha/data/models/patient_model.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "-";
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientProvider.fetchPatients();
    });

    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          "Patients",
          color: Color(0xFF006837),
          family: poppins600,
          size: 18,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF006837)),
            onPressed: () => _logout(context),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TreatmentScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Search for treatments...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Patient List
          Expanded(
            child: Consumer<PatientProvider>(
              builder: (context, patientProvider, _) {
                return RefreshIndicator(
                  color: const Color(0xFF006837),
                  onRefresh: () async {
                    await patientProvider.fetchPatients();
                  },
                  child: patientProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : patientProvider.patients.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AssetsHelper.emptyList, height: 200),
                              const SizedBox(height: 16),
                              const Text(
                                "No Patients Found",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: patientProvider.patients.length,
                          itemBuilder: (context, index) {
                            final Patient patient =
                                patientProvider.patients[index];

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      "Patient Name: ${patient.name ?? "-"}",
                                      family: poppins600,
                                      size: 16,
                                    ),
                                    6.hBox,
                                    AppText(
                                      "Phone: ${patient.phone ?? "-"}",
                                      size: 14,
                                    ),
                                    4.hBox,
                                    AppText(
                                      "Address: ${patient.address ?? "-"}",
                                      size: 14,
                                    ),
                                    4.hBox,
                                    AppText(
                                      "Branch: ${patient.branch?.name ?? "-"}",
                                      size: 14,
                                    ),
                                    6.hBox,
                                    if (patient.patientDetails != null &&
                                        patient.patientDetails!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: patient.patientDetails!
                                            .map(
                                              (detail) => Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 4.0,
                                                ),
                                                child: AppText(
                                                  "Treatment: ${detail.treatmentName ?? "-"} | Male: ${detail.male ?? 0}, Female: ${detail.female ?? 0}",
                                                  size: 14,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    6.hBox,
                                    AppText(
                                      "Total Amount: ${patient.totalAmount ?? 0} | Discount: ${patient.discountAmount ?? 0}",
                                      size: 14,
                                    ),
                                    4.hBox,
                                    AppText(
                                      "Advance: ${patient.advanceAmount ?? 0} | Balance: ${patient.balanceAmount ?? 0}",
                                      size: 14,
                                    ),
                                    6.hBox,
                                    AppText(
                                      "Appointment Date: ${_formatDate(patient.dateNdTime)}",
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
