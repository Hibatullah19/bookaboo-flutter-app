// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Book {
  String get id;
  String get title;
  String get author;

  /// Bundled cover artwork. [coverEmoji]/[coverColor] remain as the
  /// fallback glyph and the accent color pulled from the artwork.
  String get coverAsset;
  String get coverEmoji;
  int get coverColor;
  String get categoryId;
  int get ageMin;
  int get ageMax;
  int get minutes;
  double get rating;
  String get description;
  List<BookPage> get pages;
  bool get featured;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookCopyWith<Book> get copyWith =>
      _$BookCopyWithImpl<Book>(this as Book, _$identity);

  /// Serializes this Book to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Book &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.coverAsset, coverAsset) ||
                other.coverAsset == coverAsset) &&
            (identical(other.coverEmoji, coverEmoji) ||
                other.coverEmoji == coverEmoji) &&
            (identical(other.coverColor, coverColor) ||
                other.coverColor == coverColor) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.ageMin, ageMin) || other.ageMin == ageMin) &&
            (identical(other.ageMax, ageMax) || other.ageMax == ageMax) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.pages, pages) &&
            (identical(other.featured, featured) ||
                other.featured == featured));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      author,
      coverAsset,
      coverEmoji,
      coverColor,
      categoryId,
      ageMin,
      ageMax,
      minutes,
      rating,
      description,
      const DeepCollectionEquality().hash(pages),
      featured);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, coverAsset: $coverAsset, coverEmoji: $coverEmoji, coverColor: $coverColor, categoryId: $categoryId, ageMin: $ageMin, ageMax: $ageMax, minutes: $minutes, rating: $rating, description: $description, pages: $pages, featured: $featured)';
  }
}

/// @nodoc
abstract mixin class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) _then) =
      _$BookCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String author,
      String coverAsset,
      String coverEmoji,
      int coverColor,
      String categoryId,
      int ageMin,
      int ageMax,
      int minutes,
      double rating,
      String description,
      List<BookPage> pages,
      bool featured});
}

/// @nodoc
class _$BookCopyWithImpl<$Res> implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._self, this._then);

  final Book _self;
  final $Res Function(Book) _then;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? coverAsset = null,
    Object? coverEmoji = null,
    Object? coverColor = null,
    Object? categoryId = null,
    Object? ageMin = null,
    Object? ageMax = null,
    Object? minutes = null,
    Object? rating = null,
    Object? description = null,
    Object? pages = null,
    Object? featured = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      coverAsset: null == coverAsset
          ? _self.coverAsset
          : coverAsset // ignore: cast_nullable_to_non_nullable
              as String,
      coverEmoji: null == coverEmoji
          ? _self.coverEmoji
          : coverEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      coverColor: null == coverColor
          ? _self.coverColor
          : coverColor // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      ageMin: null == ageMin
          ? _self.ageMin
          : ageMin // ignore: cast_nullable_to_non_nullable
              as int,
      ageMax: null == ageMax
          ? _self.ageMax
          : ageMax // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pages: null == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<BookPage>,
      featured: null == featured
          ? _self.featured
          : featured // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [Book].
extension BookPatterns on Book {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Book value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Book() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Book value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Book():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Book value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Book() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String author,
            String coverAsset,
            String coverEmoji,
            int coverColor,
            String categoryId,
            int ageMin,
            int ageMax,
            int minutes,
            double rating,
            String description,
            List<BookPage> pages,
            bool featured)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Book() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.author,
            _that.coverAsset,
            _that.coverEmoji,
            _that.coverColor,
            _that.categoryId,
            _that.ageMin,
            _that.ageMax,
            _that.minutes,
            _that.rating,
            _that.description,
            _that.pages,
            _that.featured);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String author,
            String coverAsset,
            String coverEmoji,
            int coverColor,
            String categoryId,
            int ageMin,
            int ageMax,
            int minutes,
            double rating,
            String description,
            List<BookPage> pages,
            bool featured)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Book():
        return $default(
            _that.id,
            _that.title,
            _that.author,
            _that.coverAsset,
            _that.coverEmoji,
            _that.coverColor,
            _that.categoryId,
            _that.ageMin,
            _that.ageMax,
            _that.minutes,
            _that.rating,
            _that.description,
            _that.pages,
            _that.featured);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String title,
            String author,
            String coverAsset,
            String coverEmoji,
            int coverColor,
            String categoryId,
            int ageMin,
            int ageMax,
            int minutes,
            double rating,
            String description,
            List<BookPage> pages,
            bool featured)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Book() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.author,
            _that.coverAsset,
            _that.coverEmoji,
            _that.coverColor,
            _that.categoryId,
            _that.ageMin,
            _that.ageMax,
            _that.minutes,
            _that.rating,
            _that.description,
            _that.pages,
            _that.featured);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Book implements Book {
  const _Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.coverAsset,
      required this.coverEmoji,
      required this.coverColor,
      required this.categoryId,
      required this.ageMin,
      required this.ageMax,
      required this.minutes,
      required this.rating,
      required this.description,
      final List<BookPage> pages = const <BookPage>[],
      this.featured = false})
      : _pages = pages;
  factory _Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String author;

  /// Bundled cover artwork. [coverEmoji]/[coverColor] remain as the
  /// fallback glyph and the accent color pulled from the artwork.
  @override
  final String coverAsset;
  @override
  final String coverEmoji;
  @override
  final int coverColor;
  @override
  final String categoryId;
  @override
  final int ageMin;
  @override
  final int ageMax;
  @override
  final int minutes;
  @override
  final double rating;
  @override
  final String description;
  final List<BookPage> _pages;
  @override
  @JsonKey()
  List<BookPage> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  @JsonKey()
  final bool featured;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookCopyWith<_Book> get copyWith =>
      __$BookCopyWithImpl<_Book>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Book &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.coverAsset, coverAsset) ||
                other.coverAsset == coverAsset) &&
            (identical(other.coverEmoji, coverEmoji) ||
                other.coverEmoji == coverEmoji) &&
            (identical(other.coverColor, coverColor) ||
                other.coverColor == coverColor) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.ageMin, ageMin) || other.ageMin == ageMin) &&
            (identical(other.ageMax, ageMax) || other.ageMax == ageMax) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            (identical(other.featured, featured) ||
                other.featured == featured));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      author,
      coverAsset,
      coverEmoji,
      coverColor,
      categoryId,
      ageMin,
      ageMax,
      minutes,
      rating,
      description,
      const DeepCollectionEquality().hash(_pages),
      featured);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, coverAsset: $coverAsset, coverEmoji: $coverEmoji, coverColor: $coverColor, categoryId: $categoryId, ageMin: $ageMin, ageMax: $ageMax, minutes: $minutes, rating: $rating, description: $description, pages: $pages, featured: $featured)';
  }
}

/// @nodoc
abstract mixin class _$BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$BookCopyWith(_Book value, $Res Function(_Book) _then) =
      __$BookCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String author,
      String coverAsset,
      String coverEmoji,
      int coverColor,
      String categoryId,
      int ageMin,
      int ageMax,
      int minutes,
      double rating,
      String description,
      List<BookPage> pages,
      bool featured});
}

/// @nodoc
class __$BookCopyWithImpl<$Res> implements _$BookCopyWith<$Res> {
  __$BookCopyWithImpl(this._self, this._then);

  final _Book _self;
  final $Res Function(_Book) _then;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? coverAsset = null,
    Object? coverEmoji = null,
    Object? coverColor = null,
    Object? categoryId = null,
    Object? ageMin = null,
    Object? ageMax = null,
    Object? minutes = null,
    Object? rating = null,
    Object? description = null,
    Object? pages = null,
    Object? featured = null,
  }) {
    return _then(_Book(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      coverAsset: null == coverAsset
          ? _self.coverAsset
          : coverAsset // ignore: cast_nullable_to_non_nullable
              as String,
      coverEmoji: null == coverEmoji
          ? _self.coverEmoji
          : coverEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      coverColor: null == coverColor
          ? _self.coverColor
          : coverColor // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      ageMin: null == ageMin
          ? _self.ageMin
          : ageMin // ignore: cast_nullable_to_non_nullable
              as int,
      ageMax: null == ageMax
          ? _self.ageMax
          : ageMax // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pages: null == pages
          ? _self._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<BookPage>,
      featured: null == featured
          ? _self.featured
          : featured // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$BookPage {
  String get emoji;
  String get text;

  /// Create a copy of BookPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookPageCopyWith<BookPage> get copyWith =>
      _$BookPageCopyWithImpl<BookPage>(this as BookPage, _$identity);

  /// Serializes this BookPage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookPage &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, emoji, text);

  @override
  String toString() {
    return 'BookPage(emoji: $emoji, text: $text)';
  }
}

/// @nodoc
abstract mixin class $BookPageCopyWith<$Res> {
  factory $BookPageCopyWith(BookPage value, $Res Function(BookPage) _then) =
      _$BookPageCopyWithImpl;
  @useResult
  $Res call({String emoji, String text});
}

/// @nodoc
class _$BookPageCopyWithImpl<$Res> implements $BookPageCopyWith<$Res> {
  _$BookPageCopyWithImpl(this._self, this._then);

  final BookPage _self;
  final $Res Function(BookPage) _then;

  /// Create a copy of BookPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? text = null,
  }) {
    return _then(_self.copyWith(
      emoji: null == emoji
          ? _self.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [BookPage].
extension BookPagePatterns on BookPage {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BookPage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookPage() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BookPage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookPage():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BookPage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookPage() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String emoji, String text)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookPage() when $default != null:
        return $default(_that.emoji, _that.text);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String emoji, String text) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookPage():
        return $default(_that.emoji, _that.text);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String emoji, String text)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookPage() when $default != null:
        return $default(_that.emoji, _that.text);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BookPage implements BookPage {
  const _BookPage({required this.emoji, required this.text});
  factory _BookPage.fromJson(Map<String, dynamic> json) =>
      _$BookPageFromJson(json);

  @override
  final String emoji;
  @override
  final String text;

  /// Create a copy of BookPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookPageCopyWith<_BookPage> get copyWith =>
      __$BookPageCopyWithImpl<_BookPage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookPageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookPage &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, emoji, text);

  @override
  String toString() {
    return 'BookPage(emoji: $emoji, text: $text)';
  }
}

/// @nodoc
abstract mixin class _$BookPageCopyWith<$Res>
    implements $BookPageCopyWith<$Res> {
  factory _$BookPageCopyWith(_BookPage value, $Res Function(_BookPage) _then) =
      __$BookPageCopyWithImpl;
  @override
  @useResult
  $Res call({String emoji, String text});
}

/// @nodoc
class __$BookPageCopyWithImpl<$Res> implements _$BookPageCopyWith<$Res> {
  __$BookPageCopyWithImpl(this._self, this._then);

  final _BookPage _self;
  final $Res Function(_BookPage) _then;

  /// Create a copy of BookPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? emoji = null,
    Object? text = null,
  }) {
    return _then(_BookPage(
      emoji: null == emoji
          ? _self.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$BookCategory {
  String get id;
  String get name;
  String get imageAsset;
  String get emoji;
  int get color;

  /// Create a copy of BookCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookCategoryCopyWith<BookCategory> get copyWith =>
      _$BookCategoryCopyWithImpl<BookCategory>(
          this as BookCategory, _$identity);

  /// Serializes this BookCategory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageAsset, imageAsset) ||
                other.imageAsset == imageAsset) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, imageAsset, emoji, color);

  @override
  String toString() {
    return 'BookCategory(id: $id, name: $name, imageAsset: $imageAsset, emoji: $emoji, color: $color)';
  }
}

/// @nodoc
abstract mixin class $BookCategoryCopyWith<$Res> {
  factory $BookCategoryCopyWith(
          BookCategory value, $Res Function(BookCategory) _then) =
      _$BookCategoryCopyWithImpl;
  @useResult
  $Res call(
      {String id, String name, String imageAsset, String emoji, int color});
}

/// @nodoc
class _$BookCategoryCopyWithImpl<$Res> implements $BookCategoryCopyWith<$Res> {
  _$BookCategoryCopyWithImpl(this._self, this._then);

  final BookCategory _self;
  final $Res Function(BookCategory) _then;

  /// Create a copy of BookCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageAsset = null,
    Object? emoji = null,
    Object? color = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _self.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _self.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [BookCategory].
extension BookCategoryPatterns on BookCategory {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BookCategory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookCategory() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BookCategory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookCategory():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BookCategory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookCategory() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id, String name, String imageAsset, String emoji, int color)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BookCategory() when $default != null:
        return $default(
            _that.id, _that.name, _that.imageAsset, _that.emoji, _that.color);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id, String name, String imageAsset, String emoji, int color)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookCategory():
        return $default(
            _that.id, _that.name, _that.imageAsset, _that.emoji, _that.color);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id, String name, String imageAsset, String emoji, int color)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BookCategory() when $default != null:
        return $default(
            _that.id, _that.name, _that.imageAsset, _that.emoji, _that.color);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BookCategory implements BookCategory {
  const _BookCategory(
      {required this.id,
      required this.name,
      required this.imageAsset,
      required this.emoji,
      required this.color});
  factory _BookCategory.fromJson(Map<String, dynamic> json) =>
      _$BookCategoryFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String imageAsset;
  @override
  final String emoji;
  @override
  final int color;

  /// Create a copy of BookCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookCategoryCopyWith<_BookCategory> get copyWith =>
      __$BookCategoryCopyWithImpl<_BookCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookCategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageAsset, imageAsset) ||
                other.imageAsset == imageAsset) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, imageAsset, emoji, color);

  @override
  String toString() {
    return 'BookCategory(id: $id, name: $name, imageAsset: $imageAsset, emoji: $emoji, color: $color)';
  }
}

/// @nodoc
abstract mixin class _$BookCategoryCopyWith<$Res>
    implements $BookCategoryCopyWith<$Res> {
  factory _$BookCategoryCopyWith(
          _BookCategory value, $Res Function(_BookCategory) _then) =
      __$BookCategoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String name, String imageAsset, String emoji, int color});
}

/// @nodoc
class __$BookCategoryCopyWithImpl<$Res>
    implements _$BookCategoryCopyWith<$Res> {
  __$BookCategoryCopyWithImpl(this._self, this._then);

  final _BookCategory _self;
  final $Res Function(_BookCategory) _then;

  /// Create a copy of BookCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageAsset = null,
    Object? emoji = null,
    Object? color = null,
  }) {
    return _then(_BookCategory(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _self.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _self.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
