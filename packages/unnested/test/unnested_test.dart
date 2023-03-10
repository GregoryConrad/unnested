import 'package:flutter_test/flutter_test.dart';
import 'package:unnested/unnested.dart';

import 'widgets.dart';

class Unnest extends UnmodifiableRecursiveBuilder {}

void main() {
  test('Multi constructor widget with defaults', () {
    const expected = MultiConstructorTestWidget(
      '0',
      1,
      2,
      3,
      MultiConstructorTestWidget.namedWithNamedParameters(
        '10',
        field3: 13,
      ),
    );

    expect(expected.isEqualTo(expected), equals(true)); // FIXME delete this

    // final actual = Unnest()
    //   .multiConstructorTestWidget('0', 1, 2, 3)
    //   .multiConstructorTestWidget_namedWithNamedParameters('10', field3: 13);

    // expect(expected.isEqualTo(actual), equals(true));
  });

  test('Multi constructor widget with non defaults', () {
    const expected = MultiConstructorTestWidget(
      '0',
      1,
      2,
      3,
      MultiConstructorTestWidget.namedWithNamedParameters(
        '10',
        field1: 11,
        field2: 12,
        field3: 13,
      ),
    );

    expect(expected.isEqualTo(expected), equals(true)); // FIXME delete this

    // final actual = Unnest()
    //     .multiConstructorTestWidget('0', 1, 2, 3)
    //     .multiConstructorTestWidget_namedWithNamedParameters(
    //       '10',
    //       field1: 11,
    //       field2: 12,
    //       field3: 13,
    //     );

    // expect(expected.isEqualTo(actual), equals(true));
  });

  // FIXME uncomment
  // test('"child" parameter order precedence', () {
  //   // for reference: child > body > content

  //   final withChild = Unnest().multiChildNameTestWidget_child().end()
  //       as MultiChildNameTestWidget;
  //   expect(withChild.child, isNotNull);
  //   expect(withChild.body, isNull);
  //   expect(withChild.content, isNull);

  //   final withBody = Unnest().multiChildNameTestWidget_body().end()
  //       as MultiChildNameTestWidget;
  //   expect(withBody.child, isNull);
  //   expect(withBody.body, isNotNull);
  //   expect(withBody.content, isNull);

  //   final withContent = Unnest().multiChildNameTestWidget_content().end()
  //       as MultiChildNameTestWidget;
  //   expect(withContent.child, isNull);
  //   expect(withContent.body, isNull);
  //   expect(withContent.content, isNotNull);
  // });
}
