import 'package:elementary/elementary.dart';

class PuzzleScreenModel extends ElementaryModel {
  final _numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

  List<int> getNumbers() {
    return _numbers;
  }

  void shuffleNumbers() {
    _numbers.shuffle();
  }

  void swapWithZeroItem(int item) {
    final index = _numbers.indexOf(item);
    _numbers[_numbers.indexOf(0)] = _numbers[index];
    _numbers[index] = 0;
  }
}