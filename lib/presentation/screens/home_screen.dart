import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:amritha_ayurvedha/core/extensions/margin_extn.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amritha_ayurvedha/presentation/providers/patient_provider.dart';
import 'package:amritha_ayurvedha/data/models/patient_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(
      context,
      listen: false,
    );

    // fetch patients once when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientProvider.fetchPatients();
    });

    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          "Patients",
          color: const Color(0xFF006837),
          family: poppins600,
          size: 18,
        ),
      ),
      body: Consumer<PatientProvider>(
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
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: patientProvider.patients.length,
                    itemBuilder: (context, index) {
                      final Patient patient = patientProvider.patients[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 4,
                        ),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patient.name!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            8.hBox,
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 6),
                                AppText(patient.phone ?? "-"),
                              ],
                            ),
                            4.hBox,
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: AppText(patient.address ?? "-"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 6),
                                AppText(patient.dateNdTime ?? "-"),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
