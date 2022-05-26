import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("ゲームオーバー"),
      content: const Text("やる気あんの？"),
      actions: <Widget>[
        // ボタン領域
        ElevatedButton(
          child: const Text("ホームに戻る"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("もう一度"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
