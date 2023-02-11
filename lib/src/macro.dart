import 'package:unnested/macro_api/api.dart';

// Names commonly used for the "child" parameter, so that the macro can
// support more types of Widgets (like Scaffold, AlertDialog, etc.).
// Names are in order of precedence, i.e. the macro looks for
// "child" before "body", "body" before "content", etc.
const _childNames = [
  'child',
  'body',
  'content',
  'label',
];

class Unnested extends Macro {
  // TODO basic implementation with current macro API
}

// const unnested = Unnested();
