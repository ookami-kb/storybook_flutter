import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/core/plugin.dart';

const knobsPlugin = Plugin(
  icon: _buildIcon,
  panelBuilder: _buildPanel,
);

Widget _buildIcon(BuildContext context) => const Icon(Icons.settings);

Widget _buildPanel(BuildContext context) => const Center(child: Text('Knobs'));
