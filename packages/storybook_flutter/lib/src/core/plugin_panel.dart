import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/core/plugin.dart';

class PluginPanel extends StatefulWidget {
  const PluginPanel({
    Key? key,
    required this.plugins,
  }) : super(key: key);

  final List<Plugin> plugins;

  @override
  State<PluginPanel> createState() => _PluginPanelState();
}

final overlayKey = GlobalKey<OverlayState>();

class _PluginPanelState extends State<PluginPanel> {
  OverlayEntry? _entry;

  OverlayEntry _createEntry(WidgetBuilder childBuilder) => OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned(
              bottom: 50,
              left: 0,
              child: Dialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                insetPadding: EdgeInsets.zero,
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: childBuilder(context),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Wrap(
        runAlignment: WrapAlignment.center,
        children: widget.plugins
            .where((p) => p.icon != null)
            .map(
              (p) => IconButton(
                icon: p.icon!.call(context),
                onPressed: () {
                  p.onPressed?.call(context);
                  if (p.panelBuilder == null) return;

                  if (_entry != null) {
                    _entry!.remove();
                    _entry = null;
                  } else {
                    _entry = _createEntry(
                      (context) => p.panelBuilder!(context),
                    );
                    overlayKey.currentState!.insert(_entry!);
                  }
                },
              ),
            )
            .toList(),
      );
}
