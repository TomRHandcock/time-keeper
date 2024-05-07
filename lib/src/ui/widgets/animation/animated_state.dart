import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedState<T> extends StatefulWidget {
  final T targetValue;
  final Widget Function(BuildContext context, T target) builder;
  final bool Function(T oldValue, T newValue)? buildWhen;
  final Duration duration;
  final bool crossfade;

  const AnimatedState({
    required this.targetValue,
    required this.builder,
    this.duration = const Duration(milliseconds: 500),
    this.crossfade = false,
    this.buildWhen,
    super.key,
  });

  @override
  State<AnimatedState<T>> createState() => _AnimatedStateState();
}

class _AnimatedStateState<T> extends State<AnimatedState<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  late T _currentValue;
  late T _targetValue;
  bool _animationInProgress = false;

  double get _currentOpacity => widget.crossfade
      ? 1.0 - _animation.value
      : (1 - _animation.value * 2).clamp(0.0, 1.0);

  double get _targetOpacity => widget.crossfade
      ? _animation.value
      : (2 * _animation.value - 1).clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _currentValue = widget.targetValue;
    _targetValue = widget.targetValue;
    _animation = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation.addStatusListener(_animationStatusListener);
  }

  @override
  void didUpdateWidget(covariant AnimatedState<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldRebuild =
        widget.buildWhen?.call(_currentValue, widget.targetValue) ??
            _currentValue != _targetOpacity;
    if (shouldRebuild) {
      _targetValue = widget.targetValue;
      _restartAnimation();
    }
  }

  @override
  dispose() {
    _animation.removeStatusListener(_animationStatusListener);
    _animation.dispose();
    super.dispose();
  }

  _animationStatusListener(AnimationStatus state) {
    if (state == AnimationStatus.completed ||
        state == AnimationStatus.dismissed) {
      setState(() {
        _animation.value = 0.0;
        _animationInProgress = false;
        _currentValue = _targetValue;
        _targetValue = widget.targetValue;
        if (_currentValue != _targetValue) {
          _restartAnimation();
        }
      });
    }
  }

  _restartAnimation() async {
    debugPrint("Restarting animation");
    if (_animationInProgress && _animation.value < 0.5) {
      _animation.stop();
      await _animation.animateBack(0.0);
    }
    setState(() {
      _animation.animateTo(1.0);
      _animationInProgress = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return AnimatedSize(
          duration: widget.duration,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Opacity(
                opacity: _currentOpacity,
                child: widget.builder(context, _currentValue),
              ),
              if (_animation.value > 0)
                Opacity(
                  opacity: _targetOpacity,
                  child: widget.builder(context, _targetValue),
                ),
            ],
          ),
        );
      },
    );
  }
}
