import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unnested/unnested.dart';

class Unnest extends UnmodifiableRecursiveBuilder {}

void main() {
  // TODO add some tests that use custom test widgets that override ==
  test('Dummy test', () {
    expect(true, true);

    // ignore: unused_local_variable
    final foo = Unnest()
        .container(
          color: const Color(0xFFFF0000),
        )
        .sizedBox(
          width: 200,
          height: 200,
        )
        .container(
          color: const Color(0xFF00FF00),
        )
        .sizedBox_shrink()
        .container(color: const Color(0xFF0000FF))
        .sizedBox(
          height: 100,
          width: 50,
        )
        .end();

    // ignore: unused_local_variable
    final bar = Unnest()
        .container(
          color: const Color(0xFFFF0000),
        )
        .sizedBox(
          width: 200,
          height: 200,
        )
        .builder((context) => const Text('hi'));
  });
}
