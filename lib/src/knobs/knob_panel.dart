import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

class KnobPanel extends StatelessWidget {
  const KnobPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<Knobs>(
        builder: (context, knobs, _) {
          final items = knobs.all();

          return Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Theme.of(context).dividerColor),
              ),
              color: Theme.of(context).cardColor,
            ),
            child: items.isEmpty
                ? const Center(child: Text('No knobs'))
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) => items[index].build(),
                  ),
          );
        },
      );
}
