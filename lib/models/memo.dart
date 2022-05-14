import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'memo.g.dart';

@HiveType(typeId: 0)
class Memo extends HiveObject {
  Memo({
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    this.isLike = false,
  });

  factory Memo.create({required String text, List<String> tags = const []}) {
    return Memo(
      text: text,
      tags: tags,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Memo copyWith({
    String? text,
    List<String>? tags,
    bool? isLike,
  }) {
    return Memo(
      text: text ?? this.text,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      tags: tags ?? this.tags,
      isLike: isLike ?? this.isLike,
    );
  }

  @HiveField(0, defaultValue: '')
  final String text;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  final DateTime updatedAt;

  @HiveField(3, defaultValue: [])
  final List<String> tags;

  @HiveField(4, defaultValue: false)
  final bool isLike;
}
