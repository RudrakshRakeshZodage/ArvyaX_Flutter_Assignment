import 'dart:async';
import 'package:arvyax_flutter_assignment/domain/entities/ambience.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class PlayerState {
  final Ambience? activeAmbience;
  final List<Ambience> queue;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final bool isSessionComplete;

  PlayerState({
    this.activeAmbience,
    this.queue = const [],
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isSessionComplete = false,
  });

  PlayerState copyWith({
    Ambience? activeAmbience,
    List<Ambience>? queue,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    bool? isSessionComplete,
  }) {
    return PlayerState(
      activeAmbience: activeAmbience ?? this.activeAmbience,
      queue: queue ?? this.queue,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isSessionComplete: isSessionComplete ?? this.isSessionComplete,
    );
  }
}

class PlayerNotifier extends StateNotifier<PlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerStateSubscription;
  Timer? _sessionTimer;

  PlayerNotifier() : super(PlayerState());

  Future<void> startSession(Ambience ambience) async {
    // Reset state
    state = PlayerState(
      activeAmbience: ambience,
      duration: Duration(minutes: ambience.durationMinutes),
    );

    try {
      print('Attempting to play audio: ${ambience.audioFileName}');
      await _audioPlayer.setAsset(ambience.audioFileName); 
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.play();
      _setupSubscriptions();
      _startSessionTimer(ambience.durationMinutes);
      print('Audio playback started successfully.');
    } catch (e, stack) {
      print('FAILED to play audio asset: $e');
      print('Stack trace: $stack');
      // Fallback: simulate playing if asset is missing
      _startSimulatedPlayback(ambience.durationMinutes);
    }
  }

  void _setupSubscriptions() {
    _positionSubscription?.cancel();
    _positionSubscription = _audioPlayer.positionStream.listen((pos) {
      state = state.copyWith(position: pos);
    });

    _playerStateSubscription?.cancel();
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((s) {
      state = state.copyWith(isPlaying: s.playing);
    });
  }

  void _startSessionTimer(int minutes) {
    _sessionTimer?.cancel();
    _sessionTimer = Timer(Duration(minutes: minutes), () {
      _endSession(complete: true);
    });
  }

  void _startSimulatedPlayback(int minutes) {
    state = state.copyWith(isPlaying: true, duration: Duration(minutes: minutes));
    _sessionTimer?.cancel();
    
    // Simulate position updates every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!state.isPlaying) return;
      
      final newPos = state.position + const Duration(seconds: 1);
      if (newPos >= state.duration) {
        timer.cancel();
        _endSession(complete: true);
      } else {
        state = state.copyWith(position: newPos);
      }
      _sessionTimer = timer; // Keep track to cancel
    });
  }

  void togglePlay() {
    if (state.isPlaying) {
      _audioPlayer.pause();
      state = state.copyWith(isPlaying: false);
    } else {
      _audioPlayer.play();
      state = state.copyWith(isPlaying: true);
    }
  }

  void stopSession() {
    _endSession(complete: false);
  }

  void _endSession({required bool complete}) {
    _audioPlayer.stop();
    _sessionTimer?.cancel();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    
    if (complete && state.queue.isNotEmpty) {
      playNext();
    } else {
      state = state.copyWith(isPlaying: false, isSessionComplete: complete);
    }
  }

  void addToQueue(Ambience ambience) {
    state = state.copyWith(queue: [...state.queue, ambience]);
  }

  void removeFromQueue(int index) {
    final newQueue = List<Ambience>.from(state.queue);
    newQueue.removeAt(index);
    state = state.copyWith(queue: newQueue);
  }

  void reorderQueue(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final newQueue = List<Ambience>.from(state.queue);
    final item = newQueue.removeAt(oldIndex);
    newQueue.insert(newIndex, item);
    state = state.copyWith(queue: newQueue);
  }

  void playNext() {
    if (state.queue.isNotEmpty) {
      final next = state.queue.first;
      final newQueue = List<Ambience>.from(state.queue);
      newQueue.removeAt(0);
      state = state.copyWith(queue: newQueue);
      startSession(next);
    } else {
      _endSession(complete: true);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _sessionTimer?.cancel();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, PlayerState>((ref) {
  return PlayerNotifier();
});
