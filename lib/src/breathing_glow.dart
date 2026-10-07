import 'package:flutter/material.dart';

/// A serene, continuous ambient breathing glow and pulsing aura widget.
///
/// Wraps any [child] widget (e.g. mic buttons, profile avatars, AI indicators)
/// with a calm, organic pulsating multi-layer halo with zero external dependencies.
class BreathingGlow extends StatefulWidget {
  const BreathingGlow({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFF6B4EE6),
    this.minBlurRadius = 8.0,
    this.maxBlurRadius = 24.0,
    this.minSpreadRadius = 1.0,
    this.maxSpreadRadius = 6.0,
    this.duration = const Duration(milliseconds: 2200),
    this.curve = Curves.easeInOutSine,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.animate = true,
  })  : assert(minBlurRadius >= 0.0, 'minBlurRadius must be >= 0.0'),
        assert(maxBlurRadius >= minBlurRadius,
            'maxBlurRadius must be >= minBlurRadius'),
        assert(minSpreadRadius >= 0.0, 'minSpreadRadius must be >= 0.0'),
        assert(maxSpreadRadius >= minSpreadRadius,
            'maxSpreadRadius must be >= minSpreadRadius');

  /// The child widget to surround with a breathing halo.
  final Widget child;

  /// Primary color of the ambient glow.
  final Color glowColor;

  /// Minimum blur radius at the bottom of the breath cycle.
  final double minBlurRadius;

  /// Maximum blur radius at the peak of the breath cycle.
  final double maxBlurRadius;

  /// Minimum spread radius at the bottom of the breath cycle.
  final double minSpreadRadius;

  /// Maximum spread radius at the peak of the breath cycle.
  final double maxSpreadRadius;

  /// Duration of one complete inhale/exhale cycle.
  final Duration duration;

  /// Easing curve of the breathing cycle.
  final Curve curve;

  /// Shape of the glow container ([BoxShape.circle] or [BoxShape.rectangle]).
  final BoxShape shape;

  /// Border radius when [shape] is [BoxShape.rectangle].
  final BorderRadiusGeometry? borderRadius;

  /// Whether the glow is currently breathing. If false, rests at [minBlurRadius].
  final bool animate;

  @override
  State<BreathingGlow> createState() => _BreathingGlowState();
}

class _BreathingGlowState extends State<BreathingGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(BreathingGlow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.animate != widget.animate) {
      if (widget.animate) {
        _controller.repeat(reverse: true);
      } else {
        _controller.animateTo(0.0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations == true;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final t = reduceMotion || !widget.animate ? 0.0 : _animation.value;

        final blur = widget.minBlurRadius +
            (widget.maxBlurRadius - widget.minBlurRadius) * t;
        final spread = widget.minSpreadRadius +
            (widget.maxSpreadRadius - widget.minSpreadRadius) * t;

        final outerOpacity = (0.18 + 0.22 * t).clamp(0.0, 1.0);
        final innerOpacity = (0.28 + 0.32 * t).clamp(0.0, 1.0);

        final shadows = [
          BoxShadow(
            color: widget.glowColor.withValues(alpha: outerOpacity),
            blurRadius: blur,
            spreadRadius: spread,
          ),
          BoxShadow(
            color: widget.glowColor.withValues(alpha: innerOpacity),
            blurRadius: blur * 0.5,
            spreadRadius: spread * 0.5,
          ),
        ];

        return DecoratedBox(
          decoration: BoxDecoration(
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.rectangle
                ? widget.borderRadius ?? BorderRadius.circular(12)
                : null,
            boxShadow: shadows,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Convenience extension on [Widget] to apply [BreathingGlow].
extension BreathingGlowExtension on Widget {
  /// Wraps this widget in a serene [BreathingGlow] pulsating aura.
  Widget breathingGlow({
    Color glowColor = const Color(0xFF6B4EE6),
    double minBlurRadius = 8.0,
    double maxBlurRadius = 24.0,
    double minSpreadRadius = 1.0,
    double maxSpreadRadius = 6.0,
    Duration duration = const Duration(milliseconds: 2200),
    Curve curve = Curves.easeInOutSine,
    BoxShape shape = BoxShape.circle,
    BorderRadiusGeometry? borderRadius,
    bool animate = true,
  }) =>
      BreathingGlow(
        glowColor: glowColor,
        minBlurRadius: minBlurRadius,
        maxBlurRadius: maxBlurRadius,
        minSpreadRadius: minSpreadRadius,
        maxSpreadRadius: maxSpreadRadius,
        duration: duration,
        curve: curve,
        shape: shape,
        borderRadius: borderRadius,
        animate: animate,
        child: this,
      );
}
