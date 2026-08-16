import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings_model.freezed.dart';

/// Reading levels a grown-up can pick for their child.
enum ReadingLevel { littleListener, earlyReader, superReader }

extension ReadingLevelX on ReadingLevel {
  String get label => switch (this) {
        ReadingLevel.littleListener => 'Little Listener (2-4)',
        ReadingLevel.earlyReader => 'Early Reader (4-6)',
        ReadingLevel.superReader => 'Super Reader (6-8)',
      };

  String get emoji => switch (this) {
        ReadingLevel.littleListener => '🐣',
        ReadingLevel.earlyReader => '🐥',
        ReadingLevel.superReader => '🦅',
      };
}

/// User-adjustable app settings.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(true) bool soundEffects,
    @Default(false) bool nightLight,
    @Default(ReadingLevel.earlyReader) ReadingLevel readingLevel,
  }) = _AppSettings;
}
