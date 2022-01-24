import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle/ui/screen/puzzle_screen/puzzle_screen_widget_model.dart';

class PuzzleScreen extends ElementaryWidget<IPuzzleScreenWidgetModel> {
  const PuzzleScreen({
    Key? key,
    WidgetModelFactory wmFactory = puzzleScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPuzzleScreenWidgetModel wm) {
    return Scaffold(
      body: EntityStateNotifierBuilder<List<int>>(
        listenableEntityState: wm.puzzleState,
        builder: (_, numbers) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _NumberGrid(
                numbers: numbers!,
                swapWithZeroItem: (index) => wm.swapWithZeroItem(index),
                numberStyle: wm.numberStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              _ReshuffleButton(onPressed: () => wm.reshuffle()),
            ],
          );
        },
      ),
    );
  }
}

class _ReshuffleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ReshuffleButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.refresh,
        size: 35,
      ),
    );
  }
}

class _NumberGrid extends StatelessWidget {
  final List<int> numbers;
  final Function(int) swapWithZeroItem;
  final TextStyle numberStyle;

  const _NumberGrid({
    Key? key,
    required this.numbers,
    required this.swapWithZeroItem,
    required this.numberStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: numbers.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final number = numbers[index];
        if (number == 0) {
          return _ZeroCard(
            onAccept: (int index) => swapWithZeroItem(index),
          );
        }
        return _DefaultCard(
          number: number,
          numberStyle: numberStyle,
        );
      },
    );
  }
}

class _DefaultCard extends StatelessWidget {
  final int number;
  final TextStyle numberStyle;

  const _DefaultCard({
    Key? key,
    required this.number,
    required this.numberStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: number,
      child: _NumberCard(
        number: number,
        numberStyle: numberStyle,
      ),
      feedback: _DraggingNumberCard(
        number: number,
        numberStyle: numberStyle,
      ),
      childWhenDragging: const _EmptyCard(),
    );
  }
}

class _NumberCard extends StatelessWidget {
  final int number;
  final TextStyle numberStyle;

  const _NumberCard({
    Key? key,
    required this.number,
    required this.numberStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blue,
      child: Center(
        child: Text(
          number.toString(),
          style: numberStyle,
        ),
      ),
    );
  }
}

class _DraggingNumberCard extends StatelessWidget {
  final int number;
  final TextStyle numberStyle;

  const _DraggingNumberCard({
    Key? key,
    required this.number,
    required this.numberStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blue,
      child: SizedBox(
        height: 90,
        width: 90,
        child: Center(
          child: Text(
            number.toString(),
            style: numberStyle,
          ),
        ),
      ),
    );
  }
}

class _ZeroCard extends StatelessWidget {
  final Function(int) onAccept;

  const _ZeroCard({Key? key, required this.onAccept}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (_, __, ___) {
        return const _EmptyCard();
      },
      onAccept: onAccept,
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white54,
    );
  }
}
