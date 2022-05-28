import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris_game/components/game_over_dialog.dart';
import 'package:tetris_game/provider/providers.dart';

class TetrisGame extends HookConsumerWidget {
  const TetrisGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(minoProvider.notifier);
    // ミノが頂点まで行ったらゲームオーバーのモーダル表示
    ref.listen<bool>(
      checkGameOverProvider,
      (bool? previousBool, bool newBool) {
        if (newBool) {
          showDialog(
            context: context,
            builder: (_) {
              return const GameOverDialog();
            },
          );
          notifier.timer.cancel();
        }
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 84, 84, 84),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Consumer(
                  builder: ((context, ref, child) {
                    final list = ref.watch(blockListProvider);
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                      ),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) =>
                          list[index],
                    );
                  }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () => notifier.moveMino('left'),
                    child: const Icon(Icons.arrow_circle_left_sharp),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () => notifier.moveMino('right'),
                    child: const Icon(Icons.arrow_circle_right_sharp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
