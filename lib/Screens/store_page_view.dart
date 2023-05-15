import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryPageView extends StatelessWidget {
  final _storyController = StoryController();

  StoryPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = StoryController();
    final List<StoryItem> storyItems = [
      StoryItem.text(title: '''If you do not make time for your wellness,
you will be forced to make time for your illness.
#ReadThatAgain''', backgroundColor: Colors.indigo),
      StoryItem.pageImage(
          url:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNf55nkZRCxpvCxh3r50NdoAzf0qAf_9QwIZvDdCAMhg&usqp=CAU&ec=48665699",
          controller: _storyController),
      StoryItem.pageImage(
          url:
              "https://techcrunch.com/wp-content/uploads/2015/08/safe_image.gif",
          controller: _storyController,
          imageFit: BoxFit.contain),
    ];
    return Material(
      child: StoryView(
        storyItems: storyItems,
        controller: controller,
        inline: false,
        repeat: true,
      ),
    );
  }
}
