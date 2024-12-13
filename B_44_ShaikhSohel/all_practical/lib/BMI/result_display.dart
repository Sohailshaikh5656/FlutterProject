import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final double bmi;

  const ResultDisplay({Key? key, required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: bmi > 0
          ? Column(
        children: [
          Text(
            'Your BMI is ${bmi.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          bmi <= 18.4
              ? Text('Status: Underweight', style: TextStyle(fontSize: 20, color: Colors.yellow))
              : bmi <= 24.9
              ? Text('Status: Normal', style: TextStyle(fontSize: 20, color: Colors.green))
              : bmi <= 39.9
              ? Text('Status: Overweight', style: TextStyle(fontSize: 20, color: Colors.orange))
              : Text('Status: Obese', style: TextStyle(fontSize: 20, color: Colors.red)),
        ],
      )
          : Text(
        'Enter your details',
        style: TextStyle(fontSize: 22, color: Colors.grey),
      ),
    );
  }
}
