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

  List<Memo> fetchMemo() {
    return memos.values.toList()..sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
  }
}
