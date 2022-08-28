// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:math';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BmiCounter(),
    );
  }
}

class BmiCounter extends StatefulWidget {
  const BmiCounter({super.key});

  @override
  State<BmiCounter> createState() => _BmiCounterState();
}

class _BmiCounterState extends State<BmiCounter> {
  int currentIndex = 3;
  String result = "";
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _bmi = 0.0;
  String _message = "";

  void calculateBMI() {
    final height = double.parse(_heightController.text);
    final weight = double.parse(_weightController.text);

    double bmiResult = weight / pow(height / 100, 2);

    setState(() {
      if (height == null || height <= 0 || weight == null || weight <= 0) {
        _message = "Your height and weight must be positive numbers";
      }
    });

    setState(() {
      _bmi = bmiResult;
      //Male
      if (currentIndex == 0) {
        if (_bmi <= 0) {
          _bmi = 0.0;
        } else if (_bmi < 18.5) {
          _message = "You are underweight";
        } else if (_bmi < 25) {
          _message = "You are normal";
        } else if (_bmi < 30) {
          _message = "You are overweight";
        } else if (_bmi < 35) {
          _message = "You are obese";
        } else {
          _message = "You are extremely obese";
        }
      }
      //Female
      else if (currentIndex == 1) {
        if (_bmi <= 0) {
          _bmi = 0.0;
        } else if (_bmi < 18.5) {
          _message = "You are underweight";
        } else if (_bmi < 25) {
          _message = "You are normal";
        } else if (_bmi < 30) {
          _message = "You are overweight";
        } else if (_bmi < 35) {
          _message = "You are obese";
        } else {
          _message = "You are extremely obese";
        }
      } else {
        _bmi = 0.0;
        _message = "You have to pick your gender";
      }
    });
  }

  void clearUI() {
    _heightController.clear();
    _weightController.clear();

    setState(() {
      _message = "";
      _bmi = 0.0;
      currentIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.amber.shade100),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: clearUI,
          icon: const Icon(
            Icons.refresh,
            color: Colors.red,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton("Man", Colors.blue, 0),
                  radioButton("Woman", Colors.pink, 1),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Your height in cm: ",
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _heightController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Your height in cm",
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Your weight in kg: ",
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _weightController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Your weight in kg",
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                  ),
                  onPressed: calculateBMI,
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Your BMI is :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  _bmi.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                currentIndex == index ? Colors.green.shade100 : color),
          ),
          onPressed: () {
            changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
