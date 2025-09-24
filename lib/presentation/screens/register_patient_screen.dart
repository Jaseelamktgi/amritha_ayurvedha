import 'package:amritha_ayurvedha/core/api/api_service.dart';
import 'package:amritha_ayurvedha/data/models/patient_model.dart';
import 'package:amritha_ayurvedha/data/repositories/register_patient_repository.dart';
import 'package:amritha_ayurvedha/presentation/providers/register_patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:amritha_ayurvedha/core/extensions/margin_extn.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_button.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_text.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_textfiled.dart';

class RegisterPatientScreen extends StatelessWidget {
  const RegisterPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController whatsappNoController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController totalAmountController = TextEditingController();
    final TextEditingController discountAmountController =
        TextEditingController();
    final TextEditingController advancePaymentController =
        TextEditingController();
    final TextEditingController balancePaymentController =
        TextEditingController();
    final TextEditingController treatmentDateController =
        TextEditingController();
    final TextEditingController treatmentHourController =
        TextEditingController();
    final TextEditingController treatmentMinuteController =
        TextEditingController();
    final TextEditingController maleController = TextEditingController();
    final TextEditingController femaleController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => RegisterPatientProvider(
        repository: RegisterPatientRepositoryImpl(
          apiService: ApiService.instance,
        ),
      )..fetchBranches(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, size: 24),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.notifications_outlined, size: 28),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const AppText('Register', size: 24, family: poppins600),
                  20.hBox,
                  const Divider(),
                  20.hBox,

                  // Name
                  const AppText('Name', size: 16),
                  5.hBox,
                  AppTextField(
                    controller: nameController,
                    hintText: 'Enter your full name',
                    fillColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.black.withOpacity(0.4),
                    borderWidth: 0.85,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Please enter your full name';
                      return null;
                    },
                  ),
                  24.hBox,

                  // Whatsapp Number
                  const AppText('Whatsapp Number', size: 16),
                  5.hBox,
                  AppTextField(
                    controller: whatsappNoController,
                    hintText: 'Enter your whatsapp number',
                    fillColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.black.withOpacity(0.4),
                    borderWidth: 0.85,
                    textInputType: TextInputType.phone,
                    maxLength: 10,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Please enter your whatsapp number';
                      if (val.length != 10) return 'Invalid number';
                      return null;
                    },
                  ),
                  24.hBox,

                  const AppText('Address', size: 16),
                  5.hBox,
                  AppTextField(
                    controller: addressController,
                    hintText: 'Enter your full address',
                    fillColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.black.withOpacity(0.4),
                    borderWidth: 0.85,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Please enter your address';
                      return null;
                    },
                  ),
                  24.hBox,
                  const AppText('Location', size: 16),
                  5.hBox,
                  Consumer<RegisterPatientProvider>(
                    builder: (context, provider, _) {
                      final List<String> locations = [
                        'Trivandrum',
                        'Kochi',
                        'Calicut',
                        'Kollam',
                        'Mankavu',
                        'Trissur',
                      ];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        child: DropdownButtonFormField<String>(
                          value: provider.selectedLocation,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.4),
                                width: 0.85,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.4),
                                width: 0.85,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(
                                  0xFF006837,
                                ), // Focused border color
                                width: 1.2,
                              ),
                            ),
                          ),
                          hint: const Text('Choose your location'),
                          items: locations.map((location) {
                            return DropdownMenuItem<String>(
                              value: location,
                              child: Text(location),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              provider.setSelectedLocation(value);
                            }
                          },
                          validator: (val) {
                            if (val == null)
                              return 'Please choose your location';
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                  24.hBox,
                  const AppText('Branch', size: 16),
                  5.hBox,
                  Consumer<RegisterPatientProvider>(
                    builder: (context, provider, _) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 0,
                        ), // Adjust if you want more margin
                        child: DropdownButtonFormField<Branch>(
                          value: provider.selectedBranch,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.4),
                                width: 0.85,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.4),
                                width: 0.85,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(
                                  0xFF006837,
                                ), // Focused border color
                                width: 1.2,
                              ),
                            ),
                          ),
                          hint: const Text('Select a branch'),
                          items: provider.branches.map((Branch branch) {
                            return DropdownMenuItem<Branch>(
                              value: branch,
                              child: Text(branch.name ?? ''),
                            );
                          }).toList(),
                          onChanged: (Branch? branch) {
                            if (branch != null) {
                              provider.setSelectedBranch(branch);
                            }
                          },
                          validator: (val) {
                            if (val == null) return 'Please select a branch';
                            return null;
                          },
                        ),
                      );
                    },
                  ),

                  24.hBox,

                  // Treatments
                  AppText('Treatments', size: 16),
                  5.hBox,
                  TreatmentItem(
                    index: 0,
                    treatmentName: 'Couple combo package',
                    maleController: maleController,
                    femaleController: femaleController,
                    onEdit: () => print('Edit clicked'),
                    onClose: () => print('Close clicked'),
                  ),
                  16.hBox,
                  AppButton(
                    btntext: 'Add Treatment',
                    color: Colors.black,
                    bgColor: const Color.fromARGB(
                      255,
                      152,
                      217,
                      178,
                    ).withOpacity(.3),
                  ),
                  24.hBox,

                  // Amounts and Payment
                  AppText('Total Amount', size: 16),
                  5.hBox,
                  AppTextField(
                    controller: totalAmountController,
                    fillColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.black.withOpacity(0.4),
                    textInputType: TextInputType.number,
                    borderWidth: 0.85,
                  ),
                  24.hBox,
                  AppText('Discount Amount', size: 16),
                  5.hBox,
                  AppTextField(
                    controller: discountAmountController,
                    fillColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.black.withOpacity(0.4),
                    textInputType: TextInputType.number,
                    borderWidth: 0.85,
                  ),
                  24.hBox,
                  const AppText('Payment Option', size: 16),
                  5.hBox,
                  PaymentOptions(selectedPayment: 'Card', onChanged: (val) {}),
                  24.hBox,
                  AppText('Advance Amount', size: 16),
                  5.hBox,
                  AppTextField(
                    controller: advancePaymentController,
                    fillColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.black.withOpacity(0.4),
                    textInputType: TextInputType.number,
                    borderWidth: 0.85,
                  ),
                  24.hBox,
                  AppText('Balance Amount', size: 16),
                  5.hBox,
                  AppTextField(
                    controller: balancePaymentController,
                    fillColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.black.withOpacity(0.4),
                    textInputType: TextInputType.number,
                    borderWidth: 0.85,
                  ),
                  24.hBox,
                  AppText('Treatment Date', size: 16),
                  5.hBox,
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        // Format the date as needed, e.g., dd-MM-yyyy
                        final formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                        treatmentDateController.text = formattedDate;
                      }
                    },
                    child: AbsorbPointer(
                      child: AppTextField(
                        controller: treatmentDateController,
                        hintText: 'Select treatment date',
                        fillColor: Colors.grey.withOpacity(0.2),
                        borderColor: Colors.black.withOpacity(0.4),
                        borderWidth: 0.85,
                        suffix: const Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  24.hBox,
                  AppText('Treatment Time', size: 16),
                  5.hBox,
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              treatmentHourController.text = pickedTime.hour
                                  .toString()
                                  .padLeft(2, '0');
                              treatmentMinuteController.text = pickedTime.minute
                                  .toString()
                                  .padLeft(2, '0');
                            }
                          },
                          child: AbsorbPointer(
                            child: AppTextField(
                              controller: treatmentHourController,
                              hintText: 'Hour',
                              fillColor: Colors.grey.withOpacity(0.2),
                              borderColor: Colors.black.withOpacity(0.4),
                              suffix: const Icon(Icons.arrow_drop_down),
                              borderWidth: 0.85,
                              textInputType: TextInputType.number,
                            ),
                          ),
                        ),
                      ),
                      10.wBox,
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              treatmentHourController.text = pickedTime.hour
                                  .toString()
                                  .padLeft(2, '0');
                              treatmentMinuteController.text = pickedTime.minute
                                  .toString()
                                  .padLeft(2, '0');
                            }
                          },
                          child: AbsorbPointer(
                            child: AppTextField(
                              controller: treatmentMinuteController,
                              hintText: 'Minutes',
                              fillColor: Colors.grey.withOpacity(0.2),
                              borderColor: Colors.black.withOpacity(0.4),
                              borderWidth: 0.85,
                              suffix: const Icon(Icons.arrow_drop_down),
                              textInputType: TextInputType.number,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  50.hBox,

                  AppButton(
                    btntext: 'Save',
                    bgColor: const Color(0xFF006837),
                    verticalPadding: 10,
                    color: Colors.white,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final provider = Provider.of<RegisterPatientProvider>(
                          context,
                          listen: false,
                        );

                        final maleTreatments = maleController.text;
                        final femaleTreatments = femaleController.text;
                        final treatments = "2,3,4";

                        final dateTime =
                            "${treatmentDateController.text}-${treatmentHourController.text}:${treatmentMinuteController.text}";

                        final success = await provider.submitPatient(
                          name: nameController.text,
                          phone: whatsappNoController.text,
                          address: addressController.text,
                          totalAmount:
                              double.tryParse(totalAmountController.text) ??
                              0.0,
                          discountAmount:
                              double.tryParse(discountAmountController.text) ??
                              0.0,
                          advanceAmount:
                              double.tryParse(advancePaymentController.text) ??
                              0.0,
                          balanceAmount:
                              double.tryParse(balancePaymentController.text) ??
                              0.0,
                          dateNdTime: dateTime,
                          male: maleTreatments,
                          female: femaleTreatments,
                          treatments: treatments,
                        );

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Patient registered successfully"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to register patient"),
                            ),
                          );
                        }
                      }
                    },
                  ),

                  45.hBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentOptions extends StatelessWidget {
  final String? selectedPayment;
  final ValueChanged<String?> onChanged;

  const PaymentOptions({
    super.key,
    required this.selectedPayment,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Cash
        Row(
          children: [
            Radio<String>(
              value: 'Cash',
              groupValue: selectedPayment,
              onChanged: onChanged,
            ),
            const AppText('Cash', size: 16),
          ],
        ),
        20.wBox,
        // Card
        Row(
          children: [
            Radio<String>(
              value: 'Card',
              groupValue: selectedPayment,
              onChanged: onChanged,
            ),
            const AppText('Card', size: 16),
          ],
        ),
        20.wBox,
        // UPI
        Row(
          children: [
            Radio<String>(
              value: 'UPI',
              groupValue: selectedPayment,
              onChanged: onChanged,
            ),
            const AppText('UPI', size: 16),
          ],
        ),
      ],
    );
  }
}

class TreatmentItem extends StatelessWidget {
  final int index;
  final String treatmentName;
  final TextEditingController maleController;
  final TextEditingController femaleController;
  final VoidCallback onEdit;
  final VoidCallback onClose;

  const TreatmentItem({
    super.key,
    required this.index,
    required this.treatmentName,
    required this.maleController,
    required this.femaleController,
    required this.onEdit,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF006837).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF006837), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('${index + 1}.', size: 16, family: poppins500),
              8.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(treatmentName, size: 16, family: poppins500),
                    20.hBox,
                    Row(
                      children: [
                        AppText('Male', size: 14),
                        8.wBox,
                        SizedBox(
                          width: 50,
                          height: 35,
                          child: AppTextField(
                            controller: maleController,
                            textInputType: TextInputType.number,
                            fillColor: const Color(0xFF006837).withOpacity(0.1),
                            borderColor: const Color(0xFF006837),
                          ),
                        ),
                        24.wBox,
                        AppText('Female', size: 14),
                        8.wBox,
                        SizedBox(
                          width: 50,
                          height: 35,
                          child: AppTextField(
                            controller: femaleController,
                            textInputType: TextInputType.number,
                            fillColor: const Color(0xFF006837).withOpacity(0.1),
                            borderColor: const Color(0xFF006837),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 16,
          right: 10,
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, size: 18, color: Colors.white),
            ),
          ),
        ),

        Positioned(
          bottom: 30,
          right: 10,
          child: GestureDetector(
            onTap: onEdit,
            child: const Icon(Icons.edit, color: Color(0xFF006837)),
          ),
        ),
      ],
    );
  }
}
