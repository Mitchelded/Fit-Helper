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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();
  late Timer _timer;
  late Stopwatch _stopwatch;
  bool _isStopwatchRunning = false;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration.zero, () {});
    _stopwatch = Stopwatch();
  }


  void startStopwatch() {
    print('startStopwatch');
    _stopwatch.start();
    setState(() {
      _isStopwatchRunning = true;
    });

    // Schedule periodic updates to UI while stopwatch is running
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_isStopwatchRunning) {
        timer.cancel(); // Stop the timer when the stopwatch is stopped
      } else {
        setState(() {}); // Update the UI every second
      }
    });
  }


  void stopStopwatch() {
    print('stopStopwatch');
    _stopwatch.stop();
    setState(() {
      _isStopwatchRunning = false;
    });
  }

  void resetStopwatch() {
    print('resetStopwatch');
    _stopwatch.reset();
    setState(() {});
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
    print('resetTimer');

    setState(() {
      _timer.cancel();
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

  @override
  Widget build(BuildContext context) {
    double denominator = (double.tryParse(_hoursController.text) ?? 0) * 3600 +
        (double.tryParse(_minutesController.text) ?? 0) * 60 +
        (double.tryParse(_secondsController.text) ?? 0);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Tabs Example'),
          bottom: TabBar(
            tabs: [
              Tab(
                  text: "Timer",
                  icon: Image.asset(
                    "assets/timer.ico",
                    width: 25, // set the required width
                    height: 25, // set the required height
                  )),
              Tab(
                text: "Stopwatch",
                icon: Image.asset(
                  "assets/stopwatch.ico",
                  width: 25, // set the required width
                  height: 25, // set the required height
                ),
              ),
              Tab(
                text: "Metronome",
                icon: Image.asset(
                  "assets/metronome.ico",
                  width: 25, // set the required width
                  height: 25, // set the required height
                ),
              ),
              Tab(
                text: "BMI",
                icon: Image.asset(
                  "assets/scale.ico",
                  width: 25, // set the required width
                  height: 25, // set the required height
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content of Timer
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$_hours : $_minutes : $_seconds',
                    style: const TextStyle(fontSize: 42),
                  ),
                  const SizedBox(height: 20),
                  // Circular progress indicator
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: // Inside the CircularProgressIndicator widget
                    CircularProgressIndicator(
                      value: denominator != 0
                          ? ((_hours * 3600 + _minutes * 60 + _seconds) /
                          denominator)
                          : 0,
                      strokeWidth: 55.0, // Adjust the value as needed
                    ),
                  ),
                  const SizedBox(height: 30),
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
                ],
              ),
            ),

            // Content of Stopwatch
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${_stopwatch.elapsed.inHours.toString().padLeft(2, '0')} : '
                        '${(_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')} : '
                        '${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 42),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!_isStopwatchRunning) {
                            startStopwatch();
                          } else {
                            stopStopwatch();
                          }
                        },
                        child: Text(_isStopwatchRunning ? 'Stop Stopwatch' : 'Start Stopwatch'),
                      ),
                      ElevatedButton(
                        onPressed: resetStopwatch,
                        child: const Text('Reset Stopwatch'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content of Metronome
            Center(),

            // Content of BMI
            Center(),
          ],
        ),
      ),
    );
  }
}
