import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/ui/screen/puzzle_screen/puzzle_screen.dart';
import 'package:flutter_puzzle/ui/screen/puzzle_screen/puzzle_screen_model.dart';
import 'package:provider/provider.dart';

PuzzleScreenWidgetModel puzzleScreenWidgetModelFactory(BuildContext context) {
  final model = context.read<PuzzleScreenModel>();
  return PuzzleScreenWidgetModel(model);
}

class PuzzleScreenWidgetModel
    extends WidgetModel<PuzzleScreen, PuzzleScreenModel>
    implements IPuzzleWidgetModel {
  final _puzzleState = EntityStateNotifier<List<int>>();

  PuzzleScreenWidgetModel(
    PuzzleScreenModel model,
  ) : super(model);

  @override
  ListenableState<EntityState<List<int>>> get puzzleState => _puzzleState;

  @override
  void swapWithZeroItem(int index) {
    model.swapWithZeroItem(index);
    final numbers = model.getNumbers();
    _puzzleState.content(numbers);
  }

  @override
  void reshuffle() {
    _loadNumbers();
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _loadNumbers();
  }

  void _loadNumbers() {
    model.shuffleNumbers();
    final numbers = model.getNumbers();
    _puzzleState.content(numbers);
  }
}

abstract class IPuzzleWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<int>>> get puzzleState;

  void swapWithZeroItem(int index);

  void reshuffle();
}
