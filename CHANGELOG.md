## 1.0.0

- Initial release of `breathing_glow`.
- Ambient breathing glow aura and pulsing halo animation.
- Features:
  - `BreathingGlow` widget and `.breathingGlow(...)` extension on `Widget`.
  - Multi-layer organic soft shadows (inner focused glow + outer diffuse halo).
  - Configurable `minBlurRadius`, `maxBlurRadius`, `minSpreadRadius`, `maxSpreadRadius`.
  - Configurable `shape` (`BoxShape.circle` or `BoxShape.rectangle` with `borderRadius`).
  - Accessibility support honoring `MediaQuery.disableAnimationsOf`.
  - Zero external dependencies.
