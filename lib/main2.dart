import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void _incrementCounter(BuildContext context, String message) {


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Make sure your app is wrapped in MaterialApp
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Tabs Example'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.image),
                ),
                Tab(
                  icon: Icon(Icons.image),
                ),
                Tab(
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

                      },
                      child: const Text('Button 1'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Button 2'),
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

                      },
                      child: const Text('Button 1'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Button 2'),
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

                      },
                      child: const Text('Button 1'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Button 2'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
