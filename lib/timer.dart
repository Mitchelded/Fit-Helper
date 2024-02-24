import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TimerApp(),
    );
  }
}

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();
  late Timer _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_hours == 0 && _minutes == 0 && _seconds == 0) {
          _timer.cancel();
          // Timer has completed, you can perform any actions here
        } else if (_seconds > 0) {
          _seconds--;
        } else if (_minutes > 0) {
          _minutes--;
          _seconds = 59;
        } else if (_hours > 0) {
          _hours--;
          _minutes = 59;
          _seconds = 59;
        }
      });
    });
  }

  void resetTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _hours = int.tryParse(_hoursController.text) ?? 0;
      _minutes = int.tryParse(_minutesController.text) ?? 0;
      _seconds = int.tryParse(_secondsController.text) ?? 0;

      // Validate input ranges
      _hours = _hours.clamp(0, 99);
      _minutes = _minutes.clamp(0, 59);
      _seconds = _seconds.clamp(0, 59);

      // Update controllers to reflect clamped values
      _hoursController.text = _hours.toString();
      _minutesController.text = _minutes.toString();
      _secondsController.text = _seconds.toString();
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hours',
                    ),
                    onChanged: (value) {
                      _hours = int.tryParse(value) ?? 0;
                      _hours = _hours.clamp(0, 99);
                      _hoursController.text = _hours.toString();
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _minutesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Minutes',
                    ),
                    onChanged: (value) {
                      _minutes = int.tryParse(value) ?? 0;
                      _minutes = _minutes.clamp(0, 59);
                      _minutesController.text = _minutes.toString();
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _secondsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Seconds',
                    ),
                    onChanged: (value) {
                      _seconds = int.tryParse(value) ?? 0;
                      _seconds = _seconds.clamp(0, 59);
                      _secondsController.text = _seconds.toString();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetTimer,
              child: const Text('Start Timer'),
            ),
            const SizedBox(height: 20),
            Text(
              'Time remaining: $_hours hours $_minutes minutes $_seconds seconds',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }
}