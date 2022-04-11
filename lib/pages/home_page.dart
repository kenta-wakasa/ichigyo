import 'package:flutter/material.dart';

import '../configs/app_theme.dart';
import '../database/hive_manager.dart';
import '../models/memo.dart';
import '../widgets/memo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final textEditingController = TextEditingController()..addListener(() => setState(() {}));
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  Future<void> initialize() async {
    HiveManager.instance.memos.watch().listen((event) => setState(() {}));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    focusNode.requestFocus();
  }

  /// データベースにメモを追加する
  void onFieldSubmitted(String value) async {
    if (value.isEmpty) {
      return;
    }
    focusNode.requestFocus();

    textEditingController.clear();
    await HiveManager.instance.memos.add(
      Memo.create(text: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: HiveManager.instance
                        .fetchMemo()
                        .map(
                          (e) => MemoTile(memo: e),
                        )
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    suffixIcon: textEditingController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () async {
                              final value = textEditingController.text;
                              if (value.isEmpty) {
                                return;
                              }
                              textEditingController.clear();
                              await HiveManager.instance.memos.add(
                                Memo.create(text: value),
                              );
                            },
                            icon: const Icon(Icons.check),
                          ),
                    hintText: 'めもめも...',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppTheme.primaryColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                  autofocus: true,
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: onFieldSubmitted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
