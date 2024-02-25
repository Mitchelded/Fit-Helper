import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fit_helper/metronome.dart';
import 'package:fit_helper/timer.dart';
import 'package:fit_helper/stopwatch.dart';
import 'package:fit_helper/bmi.dart';

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

    // Schedule periodic updates to UI while stopwatch is running
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
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




  @override
  Widget build(BuildContext context) {
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
            const Center(
              child: TimerApp(),
            ),

            // Content of Stopwatch
            const Center(
              child: StopwatchApp(),
            ),

            // Content of Metronome
            const Center(
              child: Metronome(),
            ),

            // Content of BMI
            Center(
              child: BMICalculator(),
            ),
          ],
        ),
      ),
    );
  }
}
