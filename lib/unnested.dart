/// The easy way to unnest even the most complicated of widget trees.
///
/// To start, you need to create an Unnested configuration file,
/// such as unnested_config.dart (name and location do not matter):
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:my_app/my_custom_widget.dart';
/// // other widget imports...
///
/// @unnested
/// class Unnest {}
/// ```
///
/// Next, you can simply use unnested!
///
/// #### Stateless Widgets
/// ```dart
/// Widget build(BuildContext context) => Unnest()
///     .container(
///       width: 40,
///       height: 40,
///       color: Colors.yellow,
///     )
///     .center()
///     .text('Hello World!');
/// ```
///
/// #### Stateful Widgets
/// ```dart
/// Widget build(BuildContext context) {
///   final count = useState(0); // example with flutter_hooks
///
///   return Unnest()
///       .padding(padding: const EdgeInsets.all(8))
///       .text(count.value.toString());
/// }
/// ```
///
/// #### When the Last Widget Consumes a `child`
/// ```dart
/// Widget build(BuildContext context) => Unnest()
///     .sizedBox( // SizedBox() has a "child" parameter
///       width: 40,
///       height: 40,
///     )
///     .end(); // .end() finishes the build when the last widget has a child parameter
/// ```
///
/// #### Including Custom Widgets
/// In your Unnest configuration file:
/// ```dart
/// // ...
/// import 'package:my_app/my_custom_widget.dart';
/// // ...
/// ```
///
/// In your other files:
/// ```dart
/// Widget build(BuildContext context) => Unnest()
///     .center()
///     .myCustomWidget(foo: bar)
///     .someOtherCustomWidget();
/// ```
///
/// #### Widgets With Named Constructors (e.g., `SizedBox.shrink()`)
/// ```dart
/// Widget build(BuildContext context) => Unnest()
///     .someWidget()
///     .sizedBox_shrink() // just use an underscore!
///     .end();
/// ```
///
/// See Unnested's README for more.
library unnested;

export 'src/macro.dart';

// TODO delete rest of this file

// We will only depend on flutter/widgets.dart in actual macro:
import 'package:flutter/material.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

/// Defines what a [Widget] builder in Unnested should look like.
/// Essentially represents a list of composable widgets, but as a function.
/// Starts off as the identity function, [_initialWithChildWidgetBuilder],
/// and then more and more children are added in incrementally, recursively.
/// Each method chain just adds in a new nested child into a growing function.
typedef _WithChildWidgetBuilder = Widget Function(Widget child);

/// The [_WithChildWidgetBuilder] base case & identity function.
///
/// Simply returns the same widget it was given to start the recursion.
/// The alternative would be to make the [_WithChildWidgetBuilder] nullable,
/// but that is harder to implement for no gain.
///
/// A top level function since const lambdas are not yet supported.
/// See here: https://github.com/dart-lang/language/issues/1048.
Widget _initialWithChildWidgetBuilder(Widget child) => child;

/// A sample Unnested builder implementation for future reference.
/// This only implements some basic [Widget]s to help demonstrate what
/// the API will look like.
///
/// This will eventually be generated by the @unnested macro.
/// Builds arbitrarily nested widgets via a simple method chaining API.
///
/// Utilizes an unmodifiable (copy only), recursive, and eager build strategy.
/// Incurs some extra memory and performance overhead,
/// but it is the cleanest and most predictable builder implementation.
///
/// Not gotchas with this implementation since it is entirely immutable
/// and the recursion is very straightforward.
class UnmodifiableRecursiveBuilder {
  /// Constructs an Unnested builder to create a nested [Widget].
  const UnmodifiableRecursiveBuilder()
      : _widgetBuilder = _initialWithChildWidgetBuilder;

  const UnmodifiableRecursiveBuilder._(this._widgetBuilder);

  final _WithChildWidgetBuilder _widgetBuilder;

  /// See [Container].
  UnmodifiableRecursiveBuilder container({Color? color}) {
    return UnmodifiableRecursiveBuilder._(
      (child) => _widgetBuilder(Container(
        color: color,
        child: child,
      )),
    );
  }

  /// See [Center].
  UnmodifiableRecursiveBuilder center() {
    return UnmodifiableRecursiveBuilder._(
      (child) => _widgetBuilder(Center(
        child: child,
      )),
    );
  }

  /// See [Scaffold].
  UnmodifiableRecursiveBuilder scaffold({
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
  }) {
    return UnmodifiableRecursiveBuilder._(
      (child) => _widgetBuilder(Scaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        body: child,
      )),
    );
  }

  /// See [Text].
  Widget text(String text, {TextStyle? style}) {
    return _widgetBuilder(Text(text, style: style));
  }

  /// See [SizedBox].
  UnmodifiableRecursiveBuilder sizedBox({double? width, double? height}) {
    return UnmodifiableRecursiveBuilder._(
      (child) => _widgetBuilder(SizedBox(
        width: width,
        height: height,
        child: child,
      )),
    );
  }

  /// See [SizedBox.shrink].
  UnmodifiableRecursiveBuilder sizedBox_shrink() {
    return UnmodifiableRecursiveBuilder._(
      (child) => _widgetBuilder(SizedBox.shrink(child: child)),
    );
  }

  /// See [Builder].
  Widget builder(WidgetBuilder builder) {
    return _widgetBuilder(
      Builder(builder: builder),
    );
  }

  /// Terminates an Unnested method chain and returns the compiled widget.
  /// Implemented internally by adding a [SizedBox.shrink] as the final child
  /// if the supplied [child] is null.
  Widget end([Widget? child]) {
    return _widgetBuilder(child ?? const SizedBox.shrink());
  }
}
