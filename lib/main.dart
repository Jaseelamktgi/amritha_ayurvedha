import 'package:amritha_ayurvedha/core/api/api_service.dart';
import 'package:amritha_ayurvedha/data/repositories/patient_repository.dart';
import 'package:amritha_ayurvedha/data/repositories/register_patient_repository.dart';
import 'package:amritha_ayurvedha/data/repositories/treatment_repository.dart';
import 'package:amritha_ayurvedha/presentation/providers/patient_provider.dart';
import 'package:amritha_ayurvedha/presentation/providers/register_patient_provider.dart';
import 'package:amritha_ayurvedha/presentation/providers/treatment_provider.dart';
import 'package:amritha_ayurvedha/presentation/screens/home_screen.dart';
import 'package:amritha_ayurvedha/presentation/screens/register_patient_screen.dart';
import 'package:amritha_ayurvedha/presentation/screens/treatment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => PatientProvider(
            repository: PatientRepositoryImpl(apiService: ApiService.instance),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TreatmentProvider(
            repository: TreatmentRepositoryImpl(
              apiService: ApiService.instance,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterPatientProvider(
            repository: RegisterPatientRepositoryImpl(
              apiService: ApiService.instance,
            ),
          )..fetchBranches(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amritha Ayurvedha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
    );
  }
}
