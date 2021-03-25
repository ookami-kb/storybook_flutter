import 'package:flutter/foundation.dart';

enum ControlPanelOption { knobs }

class ControlPanelProvider extends ChangeNotifier {
  ControlPanelOption? _option = ControlPanelOption.knobs;

  ControlPanelOption? get option => _option;

  void toggle(ControlPanelOption option) {
    _option = _option == option ? null : option;
    notifyListeners();
  }
}
