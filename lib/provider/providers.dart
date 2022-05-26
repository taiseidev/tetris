import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris_game/constants/constants.dart';
import 'package:tetris_game/model/mino.dart';
import 'dart:math' as math;

final checkGameOverProvider = StateProvider<bool>((ref) => false);
final blockListProvider = StateProvider<List<Widget>>((ref) => []);
final finishMinoProvider = StateProvider<List<int>>((ref) => []);

final minoProvider =
    StateNotifierProvider<MinoProvider, List<int>>((ref) => MinoProvider(ref));

class MinoProvider extends StateNotifier<List<int>> {
  MinoProvider(this.ref) : super([]) {
    init();
  }

  late Timer timer;
  final Ref ref;

  void init() {
    startGame();
    redrawGridList();
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (Timer timer) {
        moveMino('bottom');
      },
    );
  }

  // ミノを生成
  void startGame() {
    final mino = Mino();
    state = mino.createMino();
  }

  void moveMino(String order) {
    if (order == 'bottom') {
      moveDown();
    } else {
      moveCommand(order);
    }
    // GridViewを再描画
    redrawGridList();
  }

  // 1秒に一回発火
  void moveDown() {
    final gameOver = gameOverCheck();
    if (gameOver) {
      ref.read(checkGameOverProvider.notifier).state = true;
    }
    final result = checkHitBox('bottom');
    if (result) {
      for (var element in state) {
        ref.watch(finishMinoProvider).add(element);
      }
      startGame();
    }
    if (!result) {
      state = state
          .map(
            (e) => e + 10,
          )
          .toList();
    }
  }

  void moveCommand(String command) {
    final result = checkHitBox(command);
    if (!result) {
      state = state
          .map(
            (e) => command == 'right' ? e + 1 : e - 1,
          )
          .toList();
    }
  }

  // ブロックを再描画
  void redrawGridList() {
    ref.read(blockListProvider.notifier).state = [
      ...List.generate(
        230,
        (index) => Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 50,
            width: 50,
            color: state.contains(index) ||
                    ref.watch(finishMinoProvider).contains(index)
                ? Colors.red
                : Colors.black,
          ),
        ),
      )
    ];
  }

  // ゲームオーバーかのチェック
  bool gameOverCheck() {
    List<bool> results = [];
    for (var num in state) {
      results.add(ref.watch(finishMinoProvider).contains(num));
    }
    return results.contains(true);
  }

  // 当たり判定
  bool checkHitBox(String s) {
    List<bool> results = [];
    if (s == 'bottom') {
      // 最下層の判定
      for (var element in Constants.bottomHitBox) {
        results.add(state.contains(element));
      }
      // 次の要素が下にある場合
      for (var element in state) {
        results.add(ref.watch(finishMinoProvider).contains(element + 10));
      }
    } else if (s == 'left') {
      for (var element in Constants.leftHitBox) {
        results.add(state.contains(element));
      }
      // 次の要素が左にある場合
      for (var element in state) {
        results.add(ref.watch(finishMinoProvider).contains(element - 1));
      }
    } else if (s == 'right') {
      for (var element in Constants.rightHitBox) {
        results.add(state.contains(element));
      }
      // 次の要素が右にある場合
      for (var element in state) {
        results.add(ref.watch(finishMinoProvider).contains(element + 1));
      }
    }
    return results.contains(true);
  }

  // カラフルな色を返す
  Color pickMinoColor() {
    final randomNum = math.Random().nextInt(7);
    Color color = Colors.red;
    switch (randomNum) {
      case 1:
        color = Colors.blue;
        break;
      case 2:
        color = Colors.yellow;
        break;
      case 3:
        color = Colors.red;
        break;
      case 4:
        color = Colors.green;
        break;
      case 5:
        color = Colors.purple;
        break;
      case 6:
        color = Colors.cyan;
        break;
    }
    return color;
  }
}
