import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  ChartBar({super.key, required this.fill});

  double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.65)),
          ),
        ),
      ),
    );
  }
}
