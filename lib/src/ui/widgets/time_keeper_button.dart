import 'package:flutter/material.dart';

class TimeKeeperButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;

  const TimeKeeperButton({
    required this.label,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
