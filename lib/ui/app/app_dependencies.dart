import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/ui/screen/puzzle_screen/puzzle_screen_model.dart';
import 'package:provider/provider.dart';

import 'app.dart';

class AppDependencies extends StatefulWidget {
  final App app;

  const AppDependencies({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  _AppDependenciesState createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  late final ThemeWrapper _themeWrapper;
  late final PuzzleScreenModel _puzzleScreenModel;

  @override
  void initState() {
    super.initState();

    _themeWrapper = ThemeWrapper();
    _puzzleScreenModel = PuzzleScreenModel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeWrapper>(
          create: (_) => _themeWrapper,
        ),
        Provider<PuzzleScreenModel>(
          create: (_) => _puzzleScreenModel,
        ),
      ],
      child: widget.app,
    );
  }
}
