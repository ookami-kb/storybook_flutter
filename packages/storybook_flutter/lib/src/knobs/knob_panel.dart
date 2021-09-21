import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/story_provider.dart';

class KnobPanel extends StatelessWidget {
  const KnobPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<StoryProvider>(
        builder: (context, knobs, _) {
          final items = knobs.all();

          return items.isEmpty
              ? const Center(child: Text('No knobs'))
              : ListView.separated(
                  primary: false,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) => items[index].build(),
                );
        },
      );
}
