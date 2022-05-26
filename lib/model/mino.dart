import 'dart:math' as math;

enum Minos {
  I,
  O,
  T,
  S,
  Z,
  L,
  J,
}

class Mino {
  List<int> usedMino = [];
  List<int> createmino = [4, 14, 24, 34];
  List<int> createMino() {
    final selectMino = math.Random().nextInt(7);
    switch (selectMino) {
      case 1:
        createmino = [4, 5, 14, 15];
        break;
      case 2:
        createmino = [4, 5, 14, 15];
        break;
      case 3:
        createmino = [5, 13, 14, 15];
        break;
      case 4:
        createmino = [4, 5, 14, 15];
        break;
      case 5:
        createmino = [4, 5, 14, 15];
        break;
      case 6:
        createmino = [4, 5, 14, 15];
        break;
    }
    return createmino;
  }
}
