# ArvyaX - Immersive Session + Reflection

ArvyaX is a premium, minimal Flutter application designed for deep focus, calm, and reflection. It provides an immersive audio experience paired with thoughtful journaling to help users reset and recharge.

## 🌟 Key Features

- **Immersive Ambience Library**: 6 curated ambiences with high-quality generative audio.
- **Advanced Session Queue**: Drag-and-drop to reorder your sessions and build a custom flow.
- **Reflective Journaling**: Capture your thoughts immediately after each session.
- **Premium UI/UX**:
  - **Dynamic Themes**: High-contrast Light and Dark modes.
  - **Interactive Controls**: Slide-to-cancel MiniPlayer and glassmorphic design.
  - **Smooth Animations**: Custom animated splash screen and mesh gradients.
- **Persistent History**: Track your past reflections using local Hive storage.

## 🛠️ Technical Architecture

The project follows **Clean Architecture** principles to ensure scalability and maintainability:

```text
lib/
├── core/               # App-wide configurations, themes, and utilities
├── data/               # Data sources, models, and repositories
├── domain/             # Business logic entities and repository interfaces
├── features/           # Feature-based modules (Ambience, Player, Journal)
│   ├── ambience/       # Grid gallery and filtering
│   ├── player/         # Audio playback and queue management
│   ├── journal/        # Reflection entry and history
└── shared/             # Reusable UI widgets and common logic
```

### 📦 Tech Stack
- **Framework**: Flutter
- **State Management**: Riverpod
- **Local Storage**: Hive
- **Audio Playback**: just_audio
- **Animations**: Shimmer, Custom Flutter Animations

## 🎵 Generative Audio (Python)

To ensure the app remains lightweight while providing high-quality meditative tones, we utilized a custom Python script (`generate_audio.py`) to synthesize audible nature frequencies.

### How it works:
- Uses `numpy` and `scipy` to generate sine waves at specific meditative frequencies (e.g., 150Hz for Focus, 100Hz for Calm).
- Applies smooth fade-in/fade-out envelopes to prevent clipping.
- Exports to 16-bit PCM `.wav` format for maximum compatibility across Windows, Android, and iOS.

**To regenerate audio assets:**
1. Ensure Python 3.x is installed.
2. Install dependencies: `pip install numpy scipy`
3. Run: `python generate_audio.py`

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.19.0 or later)
- Android Studio / VS Code
- A physical device or emulator

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/RudrakshRakeshZodage/ArvyaX_Flutter_Assignment.git
   cd ArvyaX_Flutter_Assignment
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate local code (Riverpod):**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## 📝 Assignment Requirements
This project was built as part of the ArvyaX Flutter Developer Assignment, focusing on:
- Clean Architecture
- Thoughtful UX (Premium minimal design)
- Correct State Management (Riverpod)
- Stable Audio Playback
- Local Persistence (Hive)

---
Developed with ❤️ by Antigravity (AI Assistant) for ArvyaX.
