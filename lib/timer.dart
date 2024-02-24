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
    _timer = Timer(Duration.zero, () {});
  }

  bool isButtonVisible = true;

  void _onButtonPressed(String buttonText) {
    print('Button pressed with text: $buttonText');
    // Here you can perform the necessary actions with the button text

    // hide a button after clicking
    setState(() {
      isButtonVisible = buttonText == "1" ? false : true;
    });
  }

  void startTimer() {
    print('startTimer');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_hours == 0 && _minutes == 0 && _seconds == 0) {
          timer.cancel();
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

  void stopTimer() {
    print('stopTimer');
    if (_timer.isActive) {
      print('stopTimer');
      _timer.cancel();
    }
  }

  void resetTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    } else {
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
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(
                //   onPressed: stopTimer,
                //   child: const Text('Stop Timer'),
                // ),
                // ElevatedButton(
                //   onPressed: startTimer,
                //   child: const Text('Start Timer'),
                // ),
                isButtonVisible
                    ? ElevatedButton(
                        onPressed: () {
                          startTimer();
                          _onButtonPressed("1");
                        },
                        child: const Text('Start Timer'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          stopTimer();
                          _onButtonPressed("2");
                        },
                        child: const Text('Stop Timer'),
                      ),

                ElevatedButton(
                  onPressed: () {
                    resetTimer();
                    _onButtonPressed("2");
                  },
                  child: const Text('Reset Timer'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Time remaining: $_hours hours $_minutes minutes $_seconds seconds',
              style: const TextStyle(fontSize: 24),
            ),
            isButtonVisible
                ? ElevatedButton(
                    onPressed: () => _onButtonPressed('1'),
                    child: Text('Кнопка 1'),
                  )
                : ElevatedButton(
                    onPressed: () => _onButtonPressed('2'),
                    child: Text('Кнопка 2'),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }
}
