import 'package:flutter/foundation.dart';
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

  List<Memo> get memos => HiveManager.instance.fetchMemo(tags: {'こんぶ'});

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
    // memosが更新されたら再描画する
    HiveManager.instance.memos.watch().listen((event) => setState(() {}));

    // ちょっと待つ
    await Future<void>.delayed(const Duration(milliseconds: 500));

    // TextFormFieldにフォーカスを当てる
    focusNode.requestFocus();
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      resumeCallBack: () async {
        // 待機状態から復帰したときにTextFormFieldにフォーカスを当てる
        focusNode.unfocus();
        await Future<void>.delayed(const Duration(milliseconds: 500));
        focusNode.requestFocus();
        // FIXME:requestFocusを呼ぶとなぜか空白文字が入るのでclearする
        textEditingController.clear();
      },
      suspendingCallBack: () async {},
    ));
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
                child: ListView.builder(
                  reverse: true,
                  itemCount: memos.length,
                  itemBuilder: (context, index) {
                    final memo = memos[index];
                    return MemoTile(memo: memo);
                  },
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

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({
    required this.resumeCallBack,
    required this.suspendingCallBack,
  });
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await suspendingCallBack();
        break;
    }
  }
}
