import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:flutter/material.dart';

// Add a Metronome class
class Metronome extends StatefulWidget {
  const Metronome({super.key});

  @override
  State<Metronome> createState() => _MetronomeState();
}

class _MetronomeState extends State<Metronome> {
  late Timer _metronomeTimer;
  int _bpm = 120; // Default BPM
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isButtonVisible = true;
  void _onButtonPressed(String buttonText) {
    print('Button pressed with text: $buttonText');
    // Here you can perform the necessary actions with the button text

    // hide a button after clicking
    setState(() {
      isButtonVisible = buttonText == "1" ? false : true;
    });
  }

  @override
  void initState() {
    super.initState();
    _metronomeTimer = Timer(Duration.zero, () {});
  }

  void _startMetronome() {
    _metronomeTimer = Timer.periodic(Duration(milliseconds: (60000 / _bpm).round()), (timer) {
      // Metronome tick logic
      // You can add sound or UI updates here
      _audioPlayer.setVolume(1);
      // Example: Play a tick sound
      _audioPlayer.play(AssetSource("metronome.wav"), volume: 1); // Place your tick sound file in the 'sounds' folder
    });
  }

  void _stopMetronome() {
    _metronomeTimer.cancel();
  }


  @override
  void dispose() {
    _metronomeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'BPM: $_bpm',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isButtonVisible
                ? ElevatedButton(
              onPressed: () {
                _startMetronome();
                _onButtonPressed("1");
              },
              child: const Text('Start Timer'),
            )
                : ElevatedButton(
              onPressed: () {
                _stopMetronome();
                _onButtonPressed("2");
              },
              child: const Text('Stop Timer'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Slider(
          value: _bpm.toDouble(),
          min: 30,
          max: 240,
          onChanged: (value) {
            setState(() {
              _bpm = value.round();
            });
          },
        ),
      ],
    );
  }
}
