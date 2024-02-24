import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  // Separate states for each tab
  String buttonTextTab1 = 'Press me';
  String buttonTextTab2 = 'Press me';
  String buttonTextTab3 = 'Press me';
  String buttonTextTab4 = 'Press me';

  void changeText(int tab) {
    setState(() {
      if (tab == 1) {
        buttonTextTab1 =
            (buttonTextTab1 == 'Press me') ? 'Clicked!' : 'Press me';
      } else if (tab == 2) {
        buttonTextTab2 =
            (buttonTextTab2 == 'Press me') ? 'Clicked!' : 'Press me';
      } else if (tab == 3) {
        buttonTextTab3 =
            (buttonTextTab3 == 'Press me') ? 'Clicked!' : 'Press me';
      } else if (tab == 4) {
        buttonTextTab4 =
            (buttonTextTab4 == 'Press me') ? 'Clicked!' : 'Press me';
      }
    });
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
                // icon: Icon(Icons.image),
                icon: Icon(
                  CachedNetworkImage(
                    imageUrl: 'https://example.com/icon1.png',
                    width: 30,
                    height: 30,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ) as IconData?,
                ),

              ),
              const Tab(
                text: "Stopwatch",
                icon: Icon(Icons.image),
              ),
              const Tab(
                text: "Metronome",
                icon: Icon(Icons.image),
              ),
              const Tab(
                text: "BMI",
                icon: Icon(Icons.image),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content of Tab 1
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tab 1 Content'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      changeText(1);
                    },
                    child: Text(buttonTextTab1),
                  ),
                ],
              ),
            ),

            // Content of Tab 2
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tab 2 Content'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      changeText(2);
                    },
                    child: Text(buttonTextTab2),
                  ),
                ],
              ),
            ),

            // Content of Tab 3
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tab 3 Content'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      changeText(3);
                    },
                    child: Text(buttonTextTab3),
                  ),
                ],
              ),
            ),
            // Content of Tab 4
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tab 4 Content'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      changeText(4);
                    },
                    child: Text(buttonTextTab4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
