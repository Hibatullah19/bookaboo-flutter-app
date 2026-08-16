/// Every bundled asset path in one place — no raw strings in views.
abstract class AppAssets {
  static const _covers = 'assets/covers';
  static const _categories = 'assets/categories';
  static const _illustrations = 'assets/illustrations';
  static const _avatars = 'assets/avatars';
  static const _patterns = 'assets/patterns';

  /// Cover art for a book id (`b1` … `b12`).
  static String cover(String bookId) => '$_covers/$bookId.svg';

  /// Tile art for a category id (`animals`, `space`, …).
  static String category(String categoryId) => '$_categories/$categoryId.svg';

  static const authHero = '$_illustrations/auth_hero.svg';
  static const splashMark = '$_illustrations/splash_mark.svg';
  static const onboarding1 = '$_illustrations/onboarding_1.svg';
  static const onboarding2 = '$_illustrations/onboarding_2.svg';
  static const onboarding3 = '$_illustrations/onboarding_3.svg';
  static const emptyLibrary = '$_illustrations/empty_library.svg';
  static const emptySearch = '$_illustrations/empty_search.svg';
  static const error = '$_illustrations/error.svg';

  static const patternStars = '$_patterns/stars.svg';
  static const patternWaves = '$_patterns/waves.svg';

  static const avatars = <String>[
    '$_avatars/avatar_1.svg',
    '$_avatars/avatar_2.svg',
    '$_avatars/avatar_3.svg',
    '$_avatars/avatar_4.svg',
  ];

  static String avatar(int index) => avatars[index % avatars.length];
}
