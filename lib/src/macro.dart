import 'package:unnested/macro_api/api.dart';

// Names commonly used for the "child" parameter, so that the macro can
// support more types of Widgets (like Scaffold, AlertDialog, etc.).
// Names are in order of precedence, i.e. the macro looks for
// "child" before "body", "body" before "content", etc.
// TODO remove the below lint ignore
// ignore: unused_element
const _childNames = [
  'child',
  'body',
  'content',
];

class Unnested extends Macro {
  // TODO basic implementation with current macro API
}

// const unnested = Unnested();
