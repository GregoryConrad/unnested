import 'package:flutter/widgets.dart';

class _BaseTestWidget extends StatelessWidget {
  const _BaseTestWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      throw UnsupportedError('TestWidget is not meant to be built.');
}

enum ConstructorUsed {
  unnamed,
  namedWithNamedParameters,
  // For future reference: namedWithOptionalPositionalParameters does
  // not exist because it is not possible to use for Widgets.
  // Widgets require passing the super.key, which must be done inside
  // a named parameter block.
}

class MultiConstructorTestWidget extends _BaseTestWidget {
  const MultiConstructorTestWidget(
    this.field0,
    this.field1,
    this.field2,
    this.field3,
    this.child, {
    super.key,
  }) : constructorUsed = ConstructorUsed.unnamed;
  const MultiConstructorTestWidget.namedWithNamedParameters(
    this.field0, {
    required this.field3,
    this.field1,
    this.field2 = 2,
    super.key,
  })  : constructorUsed = ConstructorUsed.namedWithNamedParameters,
        child = null;

  final ConstructorUsed constructorUsed;
  final Widget? child;
  final String field0; // for required positional argument
  final int? field1; // for optional parameter checking without default
  final int field2; // for optional parameter checking with default
  final int field3; // for required field

  // We can't override hashCode & equals on Widgets, so we use this instead:
  bool isEqualTo(MultiConstructorTestWidget other) =>
      constructorUsed == other.constructorUsed &&
      child == other.child &&
      field0 == other.field0 &&
      field1 == other.field1 &&
      field2 == other.field2 &&
      field3 == other.field3;
}

class MultiChildNameTestWidget extends _BaseTestWidget {
  const MultiChildNameTestWidget.child({
    super.key,
    this.child,
    this.body,
    this.content,
  });
  const MultiChildNameTestWidget.body({
    super.key,
    this.body,
    this.content,
  }) : child = null;
  const MultiChildNameTestWidget.content({
    super.key,
    this.content,
  })  : child = null,
        body = null;

  final Widget? child;
  final Widget? body;
  final Widget? content;
}
