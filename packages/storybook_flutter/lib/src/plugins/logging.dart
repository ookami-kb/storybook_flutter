import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

/// Plugin that allows logging from stories and callbacks.
/// Shows the recorded logs inside a panel.
///
/// With this plugin, one can also test actions inside the story and
/// then see the logs appear in the panel.
class LoggingPlugin extends Plugin {
  const LoggingPlugin()
      : super(
          icon: _buildIcon,
          wrapperBuilder: _buildWrapper,
          onPressed: _onPressed,
        );
}

abstract interface class Logger {
  void log(String message);
}

class LoggingNotifier extends ChangeNotifier implements Logger {
  final _logs = <String>[];
  bool _panelVisible = false;

  List<String> get logs => List.unmodifiable(_logs);

  bool get panelVisible => _panelVisible;

  set panelVisible(bool value) {
    _panelVisible = value;
    notifyListeners();
  }

  @override
  void log(String message) {
    _logs.insert(0, '${DateTime.now().toIso8601String()} - $message');
    notifyListeners();
  }
}

extension Logging on BuildContext {
  Logger get logger => read<LoggingNotifier>();
}

Widget _buildIcon(BuildContext context) => const Icon(
      Icons.format_quote,
      semanticLabel: 'Log output',
    );

Widget _buildWrapper(BuildContext context, Widget? child) =>
    ChangeNotifierProvider(
      create: (context) => LoggingNotifier(),
      child: Column(
        children: [
          Expanded(flex: 3, child: child ?? const SizedBox.shrink()),
          Consumer<LoggingNotifier>(
            builder: (context, notifier, child) => notifier.panelVisible
                ? Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: ListView.builder(
                        itemCount: notifier.logs.length,
                        itemBuilder: (context, index) => Text(
                          notifier.logs[index],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            height: 1.4,
                            fontFamily: 'Courier',
                            fontFamilyFallback: ['monospace'],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );

void _onPressed(BuildContext context) {
  final notifier = context.read<LoggingNotifier>();
  notifier.panelVisible = !notifier.panelVisible;
}
