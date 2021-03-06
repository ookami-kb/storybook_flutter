import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

class KnobPanel extends StatelessWidget {
  const KnobPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<Knobs>(
        builder: (context, knobs, _) => knobs.all().isEmpty
            ? Container()
            : OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
                  return Container(
                    color: Theme.of(context).cardColor,
                    width: orientation == Orientation.portrait ? null : 200,
                    child: ListView(
                      children: knobs.all().map((v) => v.build()).toList(),
                    ),
                  );
                },
              ),
      );
}
