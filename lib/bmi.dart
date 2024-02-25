// Import necessary packages
import 'package:flutter/material.dart';

// BMI Calculator Widget
class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;

    if (weight > 0 && height > 0) {
      setState(() {
        bmiResult = weight / (height * height);
        print(bmiResult);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Weight (kg)'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Height (m)'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: calculateBMI,
            child: const Text('Calculate BMI'),
          ),
          const SizedBox(height: 16.0),
          Text(
            'BMI Result: ${(bmiResult * 10000).toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18.0),
          ),

        ],
      ),
    );
  }
}

