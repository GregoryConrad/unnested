import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:macros/macros.dart';

// FIXME remove this lint ignore
// ignore_for_file: public_member_api_docs

const unnested = Unnested();

/// Names commonly used for the "child" parameter, so that the macro can
/// support more types of Widgets (like Scaffold, AlertDialog, etc.).
/// Names are in order of precedence, i.e. the macro looks for
/// "child" before "body", "body" before "content", etc.
// FIXME remove the below lint ignore
// ignore: unused_element
const _childNames = [
  'child',
  'body',
  'content',
];

const _initialWithChildWidgetBuilderName = '_initialWithChildWidgetBuilder';
const _withChildWidgetBuilderName = '_WithChildWidgetBuilder';
const _widgetBuilderName = '_widgetBuilder';
const _endFnName = 'end';

/// The Unnested macro which generates Unnested [Widget] builders.
/// FIXME basic usage example.
class Unnested implements ClassTypesMacro, ClassDeclarationsMacro {
  const Unnested();

// FIXME import flutter/widgets.dart, so we can use Widget and SizedBox.shrink?
// FIXME create a method for each Widget constructor

// FIXME if we need to use a library/import macro, consider letting users
//  not define an Unnest class at all, because we can generate the class if not
//  already generated in the individual library macro(s) themselves.

  @override
  FutureOr<void> buildTypesForClass(
    ClassDeclaration clazz,
    TypeBuilder builder,
  ) {
    builder
      ..declareType(
        _withChildWidgetBuilderName,
        DeclarationCode.fromString('''
/// Defines what a [Widget] builder in Unnested should look like.
/// Essentially represents a list of composable widgets, but as a function.
/// Starts off as the identity function, [$_initialWithChildWidgetBuilderName],
/// and then more and more children are added in incrementally, recursively.
/// Each method chain just adds in a new nested child into a growing function.
typedef $_withChildWidgetBuilderName = Widget Function(Widget child);
'''),
      )
      ..declareType(
        _initialWithChildWidgetBuilderName,
        DeclarationCode.fromString('''
/// The [$_withChildWidgetBuilderName] base case & identity function.
///
/// Simply returns the same widget it was given to start the recursion.
/// The alternative would be making the [$_withChildWidgetBuilderName] nullable,
/// but that is harder to implement for no gain.
///
/// Defined as a top level function since const lambdas are not yet supported.
/// See here: https://github.com/dart-lang/language/issues/1048.
Widget $_initialWithChildWidgetBuilderName(Widget child) => child;
'''),
      );
  }

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) {
    final className = clazz.identifier.name;

    builder
      ..declareInType(
        DeclarationCode.fromString('''
/// Constructs an Unnested builder that can create nested [Widget]s.
const $className()
    : $_widgetBuilderName = $_initialWithChildWidgetBuilderName;
'''),
      )
      ..declareInType(
        DeclarationCode.fromString(
          'const $className._(this.$_widgetBuilderName);',
        ),
      )
      ..declareInType(
        DeclarationCode.fromString(
          'final $_withChildWidgetBuilderName $_widgetBuilderName;',
        ),
      )
      ..declareInType(
        DeclarationCode.fromString('''
/// Terminates an Unnested method chain and returns the constructed widget.
/// Implemented internally by adding a [SizedBox.shrink] as the final child
/// if the supplied [child] is null.
Widget $_endFnName([Widget? child]) {
  return _widgetBuilder(child ?? const SizedBox.shrink());
}
'''),
      );
  }
}

/* Macro above is based on the following sample:

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

*/
