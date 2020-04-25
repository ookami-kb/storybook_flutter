import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

extension KnobsProvider on BuildContext {
  Knobs get knobs => Provider.of<Knobs>(this, listen: false);
}
