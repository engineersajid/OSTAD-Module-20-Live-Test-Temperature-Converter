import 'package:flutter/material.dart';
import '../../domain/usecases/temperature_converter_usecase.dart';

class TemperatureViewModel extends ChangeNotifier {
  final TemperatureConverterUseCase _converterUseCase = TemperatureConverterUseCase();

  final TextEditingController controller = TextEditingController();

  String selectedConversion = TemperatureConverterUseCase.cToF;
  String resultText = '';
  String? errorMessage;

  void setConversionType(String? type) {
    if (type != null) {
      selectedConversion = type;
      notifyListeners();
    }
  }

  // Extra interactive feature: Quick Swap conversion direction!
  void swapConversion() {
    if (selectedConversion == TemperatureConverterUseCase.cToF) {
      selectedConversion = TemperatureConverterUseCase.fToC;
    } else {
      selectedConversion = TemperatureConverterUseCase.cToF;
    }
    notifyListeners();
  }

  void calculate() {
    errorMessage = null;
    resultText = '';

    final inputString = controller.text.trim();

    // 1. Validation: Check if empty[cite: 3]
    if (inputString.isEmpty) {
      errorMessage = 'Please enter a temperature value.';
      notifyListeners();
      return;
    }

    // 2. Validation: Check if valid number[cite: 3]
    final double? inputValue = double.tryParse(inputString);
    if (inputValue == null) {
      errorMessage = 'Please enter a valid number.';
      notifyListeners();
      return;
    }

    // 3. Conversion Logic execution
    final convertedValue = _converterUseCase.convert(inputValue, selectedConversion);

    // Unit symbol determination
    final unitSymbol = selectedConversion == TemperatureConverterUseCase.cToF ? '°F' : '°C';

    // Format up to 2 decimal places[cite: 3]
    resultText = '${convertedValue.toStringAsFixed(2)} $unitSymbol';
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}