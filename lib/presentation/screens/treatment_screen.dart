import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:amritha_ayurvedha/core/extensions/margin_extn.dart';
import 'package:amritha_ayurvedha/presentation/providers/treatment_provider.dart';
import 'package:amritha_ayurvedha/presentation/screens/register_patient_screen.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_button.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_text.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.read<TreatmentProvider>().fetchTreatments());
    final bookings = List.generate(
      10,
      (index) => {
        "name": "Vikram Singh",
        "package": "Couple Combo Package (Rejuven...)",
        "date": "31/01/2025",
        "person": "Jithish",
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, size: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.notifications_outlined, size: 28),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              hintText: 'Search for treatments',
                              fillColor: Colors.white,
                              prefix: Icon(Icons.search_outlined),
                              borderColor: Colors.black.withValues(alpha: .4),
                            ),
                          ),
                          8.wBox,
                          AppButton(
                            btntext: 'Search',
                            width: 80,
                            verticalPadding: 11,
                            radius: 8,
                            textSize: 12,
                            family: poppins500,
                            bgColor: const Color(0xFF006837),
                            color: Colors.white,
                            onTap: () {},
                          ),
                        ],
                      ),
                      30.hBox,
                      Row(
                        children: [
                          AppText('Sort by:', size: 16, family: poppins500),
                          100.wBox,
                          Expanded(
                            child: AppTextField(
                              hintText: 'Date',
                              radius: 33,
                              fillColor: Colors.white,
                              suffix: GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF006837),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.hBox,
                    ],
                  ),

                  ...bookings.map((booking) {
                    final index = bookings.indexOf(booking);
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF1F1F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      '${index + 1}.',
                                      size: 18,
                                      family: poppins500,
                                    ),
                                    8.wBox,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            booking['name']!,
                                            size: 18,
                                            family: poppins500,
                                          ),
                                          4.hBox,
                                          AppText(
                                            booking['package']!,
                                            size: 16,
                                            family: poppins300,
                                            color: const Color(0xFF006837),
                                          ),
                                          8.hBox,
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Color(0xffF24E1E),
                                                    size: 16,
                                                  ),
                                                  4.wBox,
                                                  AppText(
                                                    booking['date']!,
                                                    color: Colors.grey,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                              20.wBox,
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.people_alt_outlined,
                                                    color: Color(0xffF24E1E),
                                                    size: 16,
                                                  ),
                                                  4.wBox,
                                                  AppText(
                                                    booking['person']!,
                                                    color: Colors.grey,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Divider(
                                color: Colors.grey.withValues(alpha: .4),
                                thickness: 1,
                                height: 1,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 16,
                                  top: 10,
                                  bottom: 10,
                                  left: 40,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      'View Booking details',
                                      size: 16,
                                      family: poppins300,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: const Color(0xFF389A48),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.hBox,
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppButton(
                  btntext: 'Register Now',
                  verticalPadding: 10,
                  radius: 9,
                  bgColor: const Color(0xFF006837),
                  color: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPatientScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
