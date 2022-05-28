enum MinoType {
  I,
  O,
  T,
  S,
  Z,
  L,
  J,
}

extension MinoTypeExt on MinoType {
  List<int> get mino {
    switch (this) {
      case MinoType.I:
        return [3, 4, 5, 6];
      case MinoType.O:
        return [4, 5, 14, 15];
      case MinoType.T:
        return [4, 13, 14, 15];
      case MinoType.S:
        return [4, 14, 15, 25];
      case MinoType.Z:
        return [3, 4, 14, 15];
      case MinoType.L:
        return [14, 15, 16, 6];
      case MinoType.J:
        return [4, 14, 15, 16];
    }
  }
}

List<int> select = [];

class Mino {
  List<int> mino = [];
  List<int> createMino() {
    if (select.isEmpty) {
      select = [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
      ];
    }
    int selectMino = (select.toList()..shuffle()).first;
    // 選択されたミノは削除
    select.remove(selectMino);
    switch (selectMino) {
      case 1:
        mino = MinoType.I.mino;
        break;
      case 2:
        mino = MinoType.J.mino;
        break;
      case 3:
        mino = MinoType.L.mino;
        break;
      case 4:
        mino = MinoType.O.mino;
        break;
      case 5:
        mino = MinoType.S.mino;
        break;
      case 6:
        mino = MinoType.T.mino;
        break;
      case 7:
        mino = MinoType.Z.mino;
        break;
    }
    return mino;
  }
}
