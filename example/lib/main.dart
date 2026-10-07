import 'package:flutter/material.dart';
import 'package:breathing_glow/breathing_glow.dart';

void main() {
  runApp(const BreathingGlowDemoApp());
}

class BreathingGlowDemoApp extends StatelessWidget {
  const BreathingGlowDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breathing Glow Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  bool _isListening = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121118),
      appBar: AppBar(
        title: const Text('Breathing Glow Demo'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Voice Assistant Orb',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => setState(() => _isListening = !_isListening),
              child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
                  ),
                ),
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_off,
                  size: 40,
                  color: Colors.white,
                ),
              ).breathingGlow(
                glowColor: const Color(0xFFE94057),
                minBlurRadius: 12,
                maxBlurRadius: 36,
                minSpreadRadius: 2,
                maxSpreadRadius: 10,
                duration: const Duration(milliseconds: 1800),
                animate: _isListening,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              _isListening ? 'Listening... (Tap to pause)' : 'Paused (Tap to listen)',
              style: const TextStyle(fontSize: 14, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
