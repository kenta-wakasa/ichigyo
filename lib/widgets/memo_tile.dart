import 'package:flutter/material.dart';

import '../models/memo.dart';

class MemoTile extends StatelessWidget {
  const MemoTile({Key? key, required this.memo}) : super(key: key);
  final Memo memo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(memo.text),
          ),
        ],
      ),
    );
  }
}
