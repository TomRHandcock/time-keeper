import 'package:flutter/material.dart';
import 'package:time_keeper/src/engine/utils/transform_utils.dart';

class DurationPicker extends StatelessWidget {
  final Function(Duration duration)? onDurationUpdated;
  final Duration duration;

  const DurationPicker({
    required this.duration,
    this.onDurationUpdated,
    super.key,
  });

  int get _currentHours => duration.inHours;

  int get _currentMinutes => duration.inMinutes - (duration.inHours * 60);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Wheel(
            value: duration.inHours,
            range: 24,
            step: 1,
            onChanged: (value) => onDurationUpdated?.call(
              Duration(hours: value, minutes: _currentMinutes),
            ),
          ),
          _Wheel(
            value: _currentMinutes,
            range: 60,
            step: 5,
            onChanged: (value) => onDurationUpdated?.call(
              Duration(hours: duration.inHours, minutes: value),
            ),
          ),
        ],
      ),
    );
  }
}

class _Wheel extends StatelessWidget {
  final int range;
  final int step;
  final int value;
  final Function(int value)? onChanged;

  const _Wheel({
    required this.value,
    required this.range,
    required this.step,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 100,
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(
          initialItem: (value / step).floor(),
        ),
        itemExtent: 100,
        onSelectedItemChanged: (index) => onChanged?.call(index * step % range),
        squeeze: 1.2,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List.generate(
            (range / step).floor(),
            (index) => Text(
              "${index * step}",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
      ),
    );
  }
}
