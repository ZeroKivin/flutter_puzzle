import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/ui/screen/puzzle_screen/puzzle_screen.dart';
import 'package:flutter_puzzle/ui/screen/puzzle_screen/puzzle_screen_model.dart';
import 'package:provider/provider.dart';

PuzzleScreenWidgetModel puzzleScreenWidgetModelFactory(BuildContext context) {
  final model = context.read<PuzzleScreenModel>();
  final theme = context.read<ThemeWrapper>();
  return PuzzleScreenWidgetModel(model, theme);
}

class PuzzleScreenWidgetModel
    extends WidgetModel<PuzzleScreen, PuzzleScreenModel>
    implements IPuzzleScreenWidgetModel {
  final _puzzleState = EntityStateNotifier<List<int>>();
  final ThemeWrapper _themeWrapper;
  late final TextStyle _numberStyle;

  PuzzleScreenWidgetModel(
    PuzzleScreenModel model,
    this._themeWrapper,
  ) : super(model);

  @override
  ListenableState<EntityState<List<int>>> get puzzleState => _puzzleState;

  @override
  TextStyle get numberStyle => _numberStyle;

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

    _numberStyle = _themeWrapper
        .getTextTheme(context)
        .headline4!
        .copyWith(color: Colors.white);
    _loadNumbers();
  }

  void _loadNumbers() {
    model.shuffleNumbers();
    final numbers = model.getNumbers();
    _puzzleState.content(numbers);
  }
}

abstract class IPuzzleScreenWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<int>>> get puzzleState;

  TextStyle get numberStyle;

  void swapWithZeroItem(int index);

  void reshuffle();
}
