import 'package:flutter/widgets.dart';

enum Breakpoint { small, large }

extension BreakpointExt on MediaQueryData {
  Breakpoint get breakpoint =>
      size.width >= 800 ? Breakpoint.large : Breakpoint.small;
}
