// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Book _$BookFromJson(Map<String, dynamic> json) => _Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      coverAsset: json['coverAsset'] as String,
      coverEmoji: json['coverEmoji'] as String,
      coverColor: (json['coverColor'] as num).toInt(),
      categoryId: json['categoryId'] as String,
      ageMin: (json['ageMin'] as num).toInt(),
      ageMax: (json['ageMax'] as num).toInt(),
      minutes: (json['minutes'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
      pages: (json['pages'] as List<dynamic>?)
              ?.map((e) => BookPage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BookPage>[],
      featured: json['featured'] as bool? ?? false,
    );

Map<String, dynamic> _$BookToJson(_Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'coverAsset': instance.coverAsset,
      'coverEmoji': instance.coverEmoji,
      'coverColor': instance.coverColor,
      'categoryId': instance.categoryId,
      'ageMin': instance.ageMin,
      'ageMax': instance.ageMax,
      'minutes': instance.minutes,
      'rating': instance.rating,
      'description': instance.description,
      'pages': instance.pages,
      'featured': instance.featured,
    };

_BookPage _$BookPageFromJson(Map<String, dynamic> json) => _BookPage(
      emoji: json['emoji'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$BookPageToJson(_BookPage instance) => <String, dynamic>{
      'emoji': instance.emoji,
      'text': instance.text,
    };

_BookCategory _$BookCategoryFromJson(Map<String, dynamic> json) =>
    _BookCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      imageAsset: json['imageAsset'] as String,
      emoji: json['emoji'] as String,
      color: (json['color'] as num).toInt(),
    );

Map<String, dynamic> _$BookCategoryToJson(_BookCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageAsset': instance.imageAsset,
      'emoji': instance.emoji,
      'color': instance.color,
    };
