import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/plugin.dart';

class PluginPanel extends StatefulWidget {
  const PluginPanel({
    super.key,
    required this.plugins,
    required this.layerLink,
    required this.overlayKey,
  });

  final List<Plugin> plugins;
  final LayerLink layerLink;
  final GlobalKey<OverlayState> overlayKey;

  @override
  State<PluginPanel> createState() => _PluginPanelState();
}

class _PluginPanelState extends State<PluginPanel> {
  PluginOverlay? _overlay;

  OverlayEntry _createEntry(WidgetBuilder childBuilder) => OverlayEntry(
        builder: (context) => Provider<OverlayController>(
          create: (context) => OverlayController(
            remove: () {
              _overlay?.remove();
              _overlay = null;
            },
          ),
          child: Positioned(
            height: 350,
            width: 250,
            child: CompositedTransformFollower(
              link: widget.layerLink,
              targetAnchor: Alignment.topLeft,
              followerAnchor: Alignment.bottomLeft,
              showWhenUnlinked: false,
              child: Localizations(
                delegates: const [
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                ],
                locale: const Locale('en', 'US'),
                child: Dialog(
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  insetPadding: EdgeInsets.zero,
                  child: Navigator(
                    onGenerateRoute: (_) => MaterialPageRoute<void>(
                      builder: (context) => PointerInterceptor(
                        child: Material(
                          child: childBuilder(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onPluginButtonPressed(Plugin p) {
    p.onPressed?.call(context);
    final panelBuilder = p.panelBuilder;
    if (panelBuilder == null) return;

    void insertOverlay() {
      final overlay =
          PluginOverlay(plugin: p, entry: _createEntry(panelBuilder));
      _overlay = overlay;
      widget.overlayKey.currentState?.insert(overlay.entry);
    }

    final overlay = _overlay;
    if (overlay != null) {
      overlay.remove();
      if (overlay.plugin != p) {
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
                // ignore: avoid-non-null-assertion, checked for null
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

class OverlayController {
  const OverlayController({required this.remove});

  final VoidCallback remove;
}
