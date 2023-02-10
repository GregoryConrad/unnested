The easy way to unnest even the most complicated of widget trees,
based on the power of macros in Dart 3.

# IMPORTANT
This library is just a placeholder for now with some prototype code.
Dart 3 and macros have not been released yet.

TODO:

- [ ] CI badges
- [ ] Banner/Logo
- [ ] Screenshot of example `Unnested` for `pubspec.yaml`
- [ ] Dependabot
- [ ] CI tests, followed by CD release on push to main
- [ ] Conventional commits/melos' automatic release?
- [ ] Basic implementation based on current macro API

## Features
- 📦 Unnests widget trees in an easy, declarative way
- 🤝 Effectively divides state management logic from stateless UI code
- 😌 Super simple: concept and initial prototype created in a single day!

## Getting Started

### Step 1: Add Unnested
First, simply run `flutter pub add unnested`

### Step 2: Configure Unnested
Next, create an `unnested_config.dart` somewhere in your project
(exact filename/location do not matter):

```dart
import 'package:flutter/material.dart';
import 'package:my_app/my_custom_widget.dart';
// other widget imports...

@unnested
class Unnested {}
```

### Step 3: Use Unnested
Finally, using Unnested is as simple as:

```dart
// Stateless widgets
Widget build(context) => Unnested()
    .container(
      width: 40,
      height: 40,
      color: Colors.yellow,
    )
    .center()
    .text('Hello World!');

// Stateful widgets
Widget build(context) {
  final count = useState(0); // example with flutter_hooks

  return Unnested()
      .padding(padding: const EdgeInsets.all(8))
      .text(count.value.toString());
}

// Widget trees ending in a Widget that can consume a child
Widget build(context) => Unnested()
    .sizedBox(
      width: 40,
      height: 40,
    )
    .end(); // use .end() to finish building when needed

// Custom widgets (must be included in your unnested_config.dart)
Widget build(context) => Unnested()
    .center()
    .myCustomWidget(foo: bar)
    .someOtherCustomWidget();

// Widgets with named constructors (e.g., SizedBox.shrink())
Widget build(context) => Unnested()
    .someWidget()
    .sizedBox_shrink(); // just use an underscore!
```

### Step 4: Going Beyond
Here are some helpful hints to make working with Unnested easier.

- Create a `widgets` Flutter package and use a monorepo tool like [Melos](https://melos.invertase.dev)
  - Helps split up your code in a logical way too!
- Unnested plays very nicely with `riverpod` and `flutter_hooks` for state management;
take a look at both of these amazing projects!
