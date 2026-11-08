import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/temperature_viewmodel.dart';
import '../../domain/usecases/temperature_converter_usecase.dart';

class TemperatureConverterScreen extends StatelessWidget {
  const TemperatureConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TemperatureViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2563EB),
        title: const Text(
          'Temperature converter',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            // Row for Degrees Input & Type Dropdown with Underline border style
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Degrees Field
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Degrees',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        controller: viewModel.controller,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Degrees',
                          errorText: viewModel.errorMessage,
                          // Underline border style matching the expected layout
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Type Dropdown Field
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Type',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: viewModel.selectedConversion,
                        decoration: const InputDecoration(
                          // Underline border style for dropdown
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: Colors.white,
                        items: [
                          TemperatureConverterUseCase.cToF,
                          TemperatureConverterUseCase.fToC,
                        ].map((String value) {
                          String displayName = value.contains('Celsius to Fahrenheit') ? 'Fahrenheit' : 'Celsius';
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              displayName,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: viewModel.setConversionType,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Result Section with underline style container or divider look
            const Text(
              'Result',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                ),
              ),
              child: Text(
                viewModel.resultText.isEmpty ? '--' : viewModel.resultText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Convert Button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.read<TemperatureViewModel>().calculate(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}