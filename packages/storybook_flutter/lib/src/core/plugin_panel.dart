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
  PluginOverlay? _overlay;

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
                  child: MaterialApp(
                    useInheritedMediaQuery: true,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData.light(),
                    darkTheme: ThemeData.dark(),
                    home: Scaffold(body: childBuilder(context)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void _onPluginButtonPressed(Plugin p) {
    p.onPressed?.call(context);
    if (p.panelBuilder == null) return;

    void insertOverlay() {
      _overlay = PluginOverlay(
        plugin: p,
        entry: _createEntry((context) => p.panelBuilder!(context)),
      );
      overlayKey.currentState!.insert(_overlay!.entry);
    }

    if (_overlay != null) {
      _overlay!.remove();
      if (_overlay!.plugin != p) {
        insertOverlay();
      } else {
        _overlay = null;
      }
    } else {
      insertOverlay();
    }
  }

  @override
  Widget build(BuildContext context) => Wrap(
        runAlignment: WrapAlignment.center,
        children: widget.plugins
            .where((p) => p.icon != null)
            .map(
              (p) => IconButton(
                icon: p.icon!.call(context),
                onPressed: () => _onPluginButtonPressed(p),
              ),
            )
            .toList(),
      );
}

@immutable
class PluginOverlay {
  const PluginOverlay({required this.entry, required this.plugin});

  final OverlayEntry entry;
  final Plugin plugin;

  void remove() => entry.remove();
}
