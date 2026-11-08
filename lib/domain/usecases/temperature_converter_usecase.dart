class TemperatureConverterUseCase {
  static const String cToF = 'Celsius to Fahrenheit (°C → °F)';
  static const String fToC = 'Fahrenheit to Celsius (°F → °C)';

  double convert(double value, String conversionType) {
    if (conversionType == cToF) {
      // Formula: F = (C × 9/5) + 32[cite: 2]
      return (value * 9 / 5) + 32;
    } else {
      // Formula: C = (F - 32) × 5/9[cite: 2]
      return (value - 32) * 5 / 9;
    }
  }
}