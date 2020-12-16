import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storybook_flutter/src/story.dart';

part 'story_route_path.freezed.dart';

@freezed
abstract class StoryRoutePath implements _$StoryRoutePath {
  const StoryRoutePath._();

  const factory StoryRoutePath.home() = PathHome;

  const factory StoryRoutePath.story(String name) = PathStory;

  const factory StoryRoutePath.unknown() = PathUnknown;
}
