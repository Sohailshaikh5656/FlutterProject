import 'package:all_practical/BMI/result_display.dart';
import 'package:flutter/material.dart';


class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _selectedAgeGroup = 'Adult Age 20+';
  String _weightUnit = 'kilograms';
  String _heightUnit = 'meters';
  double _bmi = 0;

  final List<String> _ageGroups = ['Adult Age 20+', 'Child Age 2-19'];
  final List<String> _weightUnits = ['kilograms', 'pounds'];
  final List<String> _heightUnits = ['meters', 'inches'];

  void _calculateBMI() {
    if (_formKey.currentState?.validate() ?? false) {
      final double weight = double.parse(_weightController.text);
      final double height = double.parse(_heightController.text);

      double convertedWeight = weight;
      double convertedHeight = height;

      if (_weightUnit == 'pounds') {
        convertedWeight = weight * 0.453592;
      }
      if (_heightUnit == 'inches') {
        convertedHeight = height * 0.0254;
      }

      setState(() {
        _bmi = convertedWeight / (convertedHeight * convertedHeight);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adult and Child BMI Calculator'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Calculate BMI for", style: TextStyle(fontSize: 18)),
              DropdownButtonFormField(
                value: _selectedAgeGroup,
                items: _ageGroups
                    .map((ageGroup) => DropdownMenuItem(
                  value: ageGroup,
                  child: Text(ageGroup),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAgeGroup = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Weight Input
              Text("Weight", style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        final double weight = double.tryParse(value) ?? 0;
                        if (weight <= 0) {
                          return 'Please enter a valid weight';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton(
                    value: _weightUnit,
                    items: _weightUnits
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _weightUnit = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Height Input
              Text("Height", style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        final double height = double.tryParse(value) ?? 0;
                        if (height <= 0) {
                          return 'Please enter a valid height';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton(
                    value: _heightUnit,
                    items: _heightUnits
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _heightUnit = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _calculateBMI,
                  child: Text('Calculate BMI', style: TextStyle(fontSize: 18)),
                ),
              ),

              SizedBox(height: 30),

              // BMI Result Display
              ResultDisplay(bmi: _bmi),
            ],
          ),
        ),
      ),
    );
  }
}
