import 'dart:async';
import 'package:flutter/material.dart';


class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key});

  @override
  State<StopwatchApp> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  late Stopwatch _stopwatch;
  bool _isStopwatchRunning = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void startStopwatch() {
    print('startStopwatch');
    _stopwatch.start();
    setState(() {
      _isStopwatchRunning = true;
    });

    // Using Stream and StreamBuilder for periodic updates
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isStopwatchRunning) {
        timer.cancel();
      } else {
        setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
                    child: Text(_isStopwatchRunning ? 'Stop' : 'Start'),
                  ),
                  ElevatedButton(
                    onPressed: resetStopwatch,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
