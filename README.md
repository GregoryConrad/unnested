<p align="center">
<a href="https://github.com/GregoryConrad/unnested/actions"><img src="https://github.com/GregoryConrad/unnested/actions/workflows/test.yml/badge.svg" alt="CI Status"></a>
<a href="https://github.com/GregoryConrad/unnested"><img src="https://img.shields.io/github/stars/GregoryConrad/unnested.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Github Stars"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>
</p>

<p align="center">
<img src="https://github.com/GregoryConrad/unnested/blob/main/assets/banner.png?raw=true" width="100%" alt="Unnested Banner" />
</p>

The easy way to unnest even the most complicated of widget trees,
based on the power of macros in Dart 3.

---

# IMPORTANT
This library is just a placeholder for now with some prototype code.
Dart 3 and macros have not been released yet.

There are still a few in-code TODOs that need to be worked out.

## Features
- 📦 Unnests widget trees in an easy, declarative way
- 🤝 Effectively divides state management logic and stateless UI code
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
class Unnest {}
```

### Step 3: Use Unnested
Finally, using Unnested is as simple as:

#### Stateless Widgets
```dart
Widget build(BuildContext context) => Unnest()
    .container(
      width: 40,
      height: 40,
      color: Colors.yellow,
    )
    .center()
    .text('Hello World!');
```

#### Stateful Widgets
```dart
Widget build(BuildContext context) {
  final count = useState(0); // example with flutter_hooks

  return Unnest()
      .padding(padding: const EdgeInsets.all(8))
      .text(count.value.toString());
}
```

#### When the Last Widget Consumes a `child`
```dart
Widget build(BuildContext context) => Unnest()
    .sizedBox( // SizedBox() has a "child" parameter
      width: 40,
      height: 40,
    )
    .end(); // .end() finishes the build when the last widget has a child parameter
```

#### Including Custom Widgets
In your Unnested configuration file:
```dart
// ...
import 'package:my_app/my_custom_widget.dart';
// ...
```

In your other files:
```dart
Widget build(BuildContext context) => Unnest()
    .center()
    .myCustomWidget(foo: bar)
    .someOtherCustomWidget();
```

#### Widgets With Named Constructors (e.g., `SizedBox.shrink()`)
```dart
Widget build(BuildContext context) => Unnest()
    .someWidget()
    .sizedBox_shrink() // just use an underscore!
    .end();
```

### Step 4: Going Beyond
Here are some helpful hints to make working with Unnested easier.

- Create a `widgets` Flutter package and use a monorepo tool like [Melos](https://melos.invertase.dev)
  - Helps split up your code in a logical way too!
- When using Unnested to create stateless widgets, using the `=>` syntax
for `build` functions helps reduce code whitespace/padding near the start of the line
- It is not always a good idea to use Unnested everywhere in your project!
  - For simple widgets, ideally with 2 or less levels of depth, it is often more readable to write out the widgets normally
  - See the example application for more details
- Unnested plays very nicely with `riverpod` and `flutter_hooks` for state management;
take a look at both of these amazing projects!
