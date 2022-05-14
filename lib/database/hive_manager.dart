import 'package:hive_flutter/hive_flutter.dart';

import '../models/memo.dart';

class HiveManager {
  HiveManager._();
  static final instance = HiveManager._();

  late final Box<Memo> memos;

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MemoAdapter());
    memos = await Hive.openBox<Memo>('memos');
  }

  List<Memo> fetchMemo({
    bool descending = true,
    Set<String> tags = const {},
  }) {
    return memos.values.where((element) {
      if (tags.isEmpty) {
        return true;
      }
      return element.tags.toSet().containsAll(tags);
    }).toList()
      ..sort(
        (a, b) {
          if (descending) {
            return b.updatedAt.compareTo(a.updatedAt);
          } else {
            return a.updatedAt.compareTo(b.updatedAt);
          }
        },
      );
  }
}
