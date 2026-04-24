import 'package:arvyax_flutter_assignment/features/journal/presentation/journal_screen.dart';
import 'package:arvyax_flutter_assignment/features/player/presentation/providers/player_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({super.key});

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    final ambience = playerState.activeAmbience;

    // Navigation trigger on session complete
    ref.listen(playerProvider, (prev, next) {
      if (next.isSessionComplete) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => JournalScreen(ambienceTitle: ambience?.title ?? 'Session'),
          ),
        );
      }
    });

    if (ambience == null) return const Scaffold(body: Center(child: Text('No active session')));

    return Scaffold(
      body: Stack(
        children: [
          // Background Animation
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      Theme.of(context).colorScheme.background,
                    ],
                    radius: _pulseAnimation.value,
                  ),
                ),
              );
            },
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Cover Image with soft shadow
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(ambience.thumbnailUrl, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    ambience.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ambience.tag,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Progress Bar
                  ProgressBar(
                    progress: playerState.position,
                    total: playerState.duration,
                    onSeek: (duration) {
                      // Logic for seeking
                    },
                    baseBarColor: Theme.of(context).colorScheme.outlineVariant,
                    progressBarColor: Theme.of(context).colorScheme.primary,
                    thumbColor: Theme.of(context).colorScheme.primary,
                    timeLabelTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 80,
                        icon: Icon(
                          playerState.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => ref.read(playerProvider.notifier).togglePlay(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  
                  // End Session Button
                  TextButton(
                    onPressed: () => _showEndDialog(context, ref),
                    child: Text(
                      'End Session',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          // Back Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, size: 40),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showEndDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Session?'),
        content: const Text('Are you sure you want to end your session now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final ambience = ref.read(playerProvider).activeAmbience;
              ref.read(playerProvider.notifier).stopSession();
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => JournalScreen(ambienceTitle: ambience?.title ?? 'Session'),
                ),
              );
            },
            child: Text(
              'End',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
