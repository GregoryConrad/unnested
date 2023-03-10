import 'package:flutter/material.dart';
import 'package:unnested/unnested.dart';

// ignore_for_file: public_member_api_docs

class Unnest extends UnmodifiableRecursiveBuilder {}

void main() {
  runApp(
    const MaterialApp(
      title: 'Unnested Demo',
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) => Unnest()
      // Notice how we used the => syntax above, it helps the code formatter
      // put our method chains closer to the start of line. You don't need to,
      // but using => can help reduce the extra whitespace padding.
      .scaffold(
        // We could use an Unnest() for the AppBar/Text and FAB/Icon below,
        // but sometimes using Unnest() hurts readability.
        // That's the case here, where we introduce just 1 extra level of depth.
        // Consider using Unnest() only when you have 2+ levels of depth.
        // You can always still use regular widgets at your discretion!
        appBar: AppBar(title: const Text('Unnested Demo')),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      )
      .center()
      .text(
        // Notice how the parameter syntax from the Text() constructor is
        // exactly the same here, including the positional "text" parameter.
        '$_counter',
        style: Theme.of(context).textTheme.headlineLarge,
      );
}
