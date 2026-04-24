# ArvyaX Immersive Session + Reflection App

A premium, calm, and minimal Flutter application built for the ArvyaX developer interview assignment.

## Architecture

This project follows **Clean Architecture** principles to ensure separation of concerns, testability, and maintainability.

### Folder Structure
- `lib/core/`: Application-wide constants, theme definitions, and utilities.
- `lib/data/`: Data layer containing models (JSON serialization, Hive adapters) and repository implementations.
- `lib/domain/`: Domain layer containing business entities and repository interfaces.
- `lib/features/`: Feature-based modules (Ambience, Player, Journal).
  - Each feature contains its own `presentation` logic (widgets, screens, and Riverpod providers).
- `lib/shared/`: Reusable widgets shared across multiple features (e.g., `MiniPlayer`).

### State Management
I chose **Riverpod** for state management because of its compile-time safety, ease of dependency injection, and ability to handle asynchronous data (AsyncValue) seamlessly.
- **Data Flow**: `Repository` (Data source) -> `Provider/Notifier` (Controller) -> `ConsumerWidget` (UI).

### Persistence
**Hive** is used for local persistence of journal entries. It was chosen for its high performance, simplicity in Flutter, and low overhead compared to SQLite.

## Packages Used
- `flutter_riverpod`: For robust state management.
- `hive` & `hive_flutter`: For fast local persistence.
- `just_audio`: For stable and feature-rich audio playback.
- `audio_video_progress_bar`: To provide a premium seek-bar experience.
- `google_fonts`: To use the 'Outfit' font for a modern aesthetic.
- `uuid`: To generate unique IDs for journal entries.
- `intl`: For date and time formatting in history.

## How to Run

1.  **Clone the repository**:
    ```bash
    git clone <repo_url>
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Generate code** (for Hive and JSON):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  **Run the app**:
    ```bash
    flutter run
    ```

## Tradeoffs & Improvements

### Current Tradeoffs
- **Audio Assets**: Due to the environment constraints, real audio assets are simulated if missing. In a production app, high-quality FLAC/MP3 files would be bundled or streamed.
- **Animations**: Implemented a subtle pulse animation. Could be enhanced with `Rive` for more complex interactive visuals.

### Future Improvements (If I had 2 more days)
- **Background Playback**: Implement a background service for audio so the session continues when the app is minimized (Option 1 Bonus).
- **Unit Testing**: Add comprehensive widget and golden tests to ensure UI consistency across devices.
- **Custom Painter Visuals**: Replace the gradient pulse with a custom painter wave shimmer for a more "organic" feel.
- **Cloud Sync**: Integrate with Supabase or Firebase to sync journal entries across devices.
