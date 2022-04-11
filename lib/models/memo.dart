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

  factory Memo.create({required String text}) {
    return Memo(
      text: text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Memo copyWith({
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    bool? isLike,
  }) {
    return Memo(
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
