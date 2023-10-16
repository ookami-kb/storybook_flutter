import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum Layout { compact, expanded, auto }

enum EffectiveLayout { compact, expanded }

class LayoutProvider extends ValueNotifier<Layout> {
  LayoutProvider(super.value);
}

class LayoutPlugin extends Plugin {
  LayoutPlugin(
    Layout initialLayout,
    double autoLayoutThreshold, {
    bool enableLayout = true,
  }) : super(
          icon: enableLayout ? _buildIcon : null,
          wrapperBuilder: (context, child) => _buildWrapper(
            context,
            child,
            initialLayout,
            autoLayoutThreshold,
          ),
          onPressed: _onPressed,
        );
}

Widget _buildIcon(BuildContext context) =>
    switch (context.watch<LayoutProvider>().value) {
      Layout.auto => const Icon(Icons.view_carousel),
      Layout.compact => const Icon(Icons.view_agenda),
      Layout.expanded => const Icon(Icons.width_normal),
    };

Widget _buildWrapper(
  BuildContext _,
  Widget? child,
  Layout initialLayout,
  double autoLayoutThreshold,
) =>
    ChangeNotifierProvider(
      create: (context) => LayoutProvider(initialLayout),
      child: _EffectiveLayoutBuilder(
        autoLayoutThreshold: autoLayoutThreshold,
        child: child,
      ),
    );

void _onPressed(BuildContext context) {
  final layout = context.read<LayoutProvider>();
  final position = Layout.values.indexOf(layout.value);
  layout.value = Layout.values[(position + 1) % Layout.values.length];
}

class _EffectiveLayoutBuilder extends StatefulWidget {
  const _EffectiveLayoutBuilder({
    required this.autoLayoutThreshold,
    required this.child,
  });

  final double autoLayoutThreshold;
  final Widget? child;

  @override
  State<_EffectiveLayoutBuilder> createState() =>
      _EffectiveLayoutBuilderState();
}

class _EffectiveLayoutBuilderState extends State<_EffectiveLayoutBuilder> {
  late EffectiveLayout _layout;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.sizeOf(context).width;
    _layout = switch (context.watch<LayoutProvider>().value) {
      Layout.auto => width < widget.autoLayoutThreshold
          ? EffectiveLayout.compact
          : EffectiveLayout.expanded,
      Layout.compact => EffectiveLayout.compact,
      Layout.expanded => EffectiveLayout.expanded,
    };
  }

  @override
  Widget build(BuildContext context) => Provider.value(
        value: _layout,
        child: widget.child,
      );
}
