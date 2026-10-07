# Breathing Glow 🪐

A serene, organic ambient breathing glow and pulsing aura widget for Flutter with **zero third-party dependencies**.

Perfect for voice recording buttons, AI listening orbs, profile avatars, active status indicators, and meditation apps.

[![pub package](https://img.shields.io/badge/pub.dev-1.0.0-blue.svg)](https://github.com/Codes-of-NazmuL/breathing_glow)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev)

---

## ✨ Features

- 🌿 **Zero Dependencies:** Pure Flutter SDK (`flutter/material.dart`).
- 🌊 **Organic Multi-Layer Glow:** Generates both a tight, bright inner core and a diffuse, atmospheric outer halo for silky depth.
- ⚡️ **Hardware-Accelerated:** Transitions run smoothly without forcing unneeded rebuilds of your child widget.
- ⭕️ **Any Shape:** Supports both circular buttons/avatars and rounded rectangular cards.
- ♿️ **Accessibility Ready:** Honors `MediaQuery.disableAnimationsOf` to keep animations comfortable for users who prefer reduced motion.
- 🪄 **1-Line Extension:** Just call `.breathingGlow()` on any widget.

---

## 📦 Installation

Add `breathing_glow` via Git in your `pubspec.yaml`:

```yaml
dependencies:
  breathing_glow:
    git:
      url: https://github.com/Codes-of-NazmuL/breathing_glow.git
      ref: main
```

Or install from terminal:

```bash
flutter pub add 'breathing_glow:{"git":{"url":"https://github.com/Codes-of-NazmuL/breathing_glow.git"}}'
```

---

## 🚀 Quick Usage

### 1. Extension Method (Simplest)

```dart
import 'package:flutter/material.dart';
import 'package:breathing_glow/breathing_glow.dart';

// Circular voice mic button with ambient glow:
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.mic),
).breathingGlow(
  glowColor: Colors.deepPurpleAccent,
  minBlurRadius: 10,
  maxBlurRadius: 28,
);

// Rectangular active status card:
Container(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(20),
  ),
  child: const Text('LIVE NOW', style: TextStyle(color: Colors.white)),
).breathingGlow(
  glowColor: Colors.greenAccent,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(20),
);
```

### 2. Widget Wrapper

```dart
BreathingGlow(
  glowColor: const Color(0xFF5A2E2E),
  minBlurRadius: 8,
  maxBlurRadius: 24,
  duration: const Duration(seconds: 2),
  child: const CircleAvatar(
    radius: 36,
    backgroundImage: AssetImage('assets/avatar.png'),
  ),
)
```

---

## ⚙️ Customization Options

| Property | Type | Default | Description |
|---|---|---|---|
| `glowColor` | `Color` | `Color(0xFF6B4EE6)` | Ambient glow base color. |
| `minBlurRadius` | `double` | `8.0` | Blur radius at the bottom of the breath cycle. |
| `maxBlurRadius` | `double` | `24.0` | Blur radius at the peak of the breath cycle. |
| `minSpreadRadius` | `double` | `1.0` | Spread radius at minimum breath. |
| `maxSpreadRadius` | `double` | `6.0` | Spread radius at peak breath. |
| `duration` | `Duration` | `2200ms` | Duration of one complete inhale/exhale cycle. |
| `curve` | `Curve` | `Curves.easeInOutSine` | Easing curve for the breathing cycle. |
| `shape` | `BoxShape` | `BoxShape.circle` | Glow boundary shape. |
| `borderRadius` | `BorderRadiusGeometry?` | `null` | Radius when shape is rectangle. |
| `animate` | `bool` | `true` | Toggles active breathing pulsation on/off. |

---

## 👨‍💻 Author & Maintainer

Created with ❤️ by **Nazmul Islam**

- **GitHub:** [@Codes-of-NazmuL](https://github.com/Codes-of-NazmuL)
- **Organization:** Softvence

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
