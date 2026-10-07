import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:breathing_glow/breathing_glow.dart';

void main() {
  testWidgets('BreathingGlow renders child properly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BreathingGlow(
            child: Icon(Icons.mic),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.mic), findsOneWidget);
  });

  testWidgets('BreathingGlow applies BoxShadow decoration', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BreathingGlow(
            glowColor: Colors.deepPurple,
            minBlurRadius: 10.0,
            maxBlurRadius: 30.0,
            child: SizedBox(width: 50, height: 50),
          ),
        ),
      ),
    );

    final decoratedBoxFinder = find.descendant(
      of: find.byType(BreathingGlow),
      matching: find.byType(DecoratedBox),
    );
    expect(decoratedBoxFinder, findsOneWidget);

    final decoratedBox = tester.widget<DecoratedBox>(decoratedBoxFinder);
    final boxDecoration = decoratedBox.decoration as BoxDecoration;
    expect(boxDecoration.boxShadow, isNotNull);
    expect(boxDecoration.boxShadow!.length, 2);
  });

  testWidgets('BreathingGlow pulsates over time when animate is true',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BreathingGlow(
            glowColor: Colors.teal,
            minBlurRadius: 10.0,
            maxBlurRadius: 30.0,
            duration: Duration(milliseconds: 1000),
            animate: true,
            child: SizedBox(width: 50, height: 50),
          ),
        ),
      ),
    );

    final decoratedBoxFinder = find.descendant(
      of: find.byType(BreathingGlow),
      matching: find.byType(DecoratedBox),
    );

    // Initial state at t=0
    final initialBox =
        tester.widget<DecoratedBox>(decoratedBoxFinder).decoration as BoxDecoration;
    final initialBlur = initialBox.boxShadow![0].blurRadius;
    expect(initialBlur, closeTo(10.0, 0.1));

    // Advance half a cycle (peak of inhale)
    await tester.pump(const Duration(milliseconds: 1000));

    final peakBox =
        tester.widget<DecoratedBox>(decoratedBoxFinder).decoration as BoxDecoration;
    final peakBlur = peakBox.boxShadow![0].blurRadius;
    expect(peakBlur, closeTo(30.0, 0.5));
  });

  testWidgets('Widget extension .breathingGlow() works properly',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Icon(Icons.star).breathingGlow(
            glowColor: Colors.amber,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byType(BreathingGlow), findsOneWidget);
  });
}
