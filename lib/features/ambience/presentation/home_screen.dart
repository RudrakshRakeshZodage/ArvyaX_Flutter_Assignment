import 'package:arvyax_flutter_assignment/features/ambience/presentation/details_screen.dart';
import 'package:arvyax_flutter_assignment/features/ambience/presentation/providers/ambience_providers.dart';
import 'package:arvyax_flutter_assignment/features/ambience/presentation/widgets/tag_filter_chips.dart';
import 'package:arvyax_flutter_assignment/features/journal/presentation/history_screen.dart';
import 'package:arvyax_flutter_assignment/shared/widgets/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ambiencesAsync = ref.watch(filteredAmbiencesProvider);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 160,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/logo.png', height: 40),
                            IconButton(
                              icon: const Icon(Icons.history_rounded, size: 28),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const HistoryScreen()),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Breathe, ArvyaX.',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      _SearchBar(),
                      const SizedBox(height: 16),
                      const TagFilterChips(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              ambiencesAsync.when(
                data: (list) {
                  if (list.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No ambiences found'),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                ref.read(searchQueryProvider.notifier).state = '';
                                ref.read(selectedTagProvider.notifier).state = null;
                              },
                              child: const Text('Clear Filters'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final ambience = list[index];
                          return _AmbienceCard(ambience: ambience);
                        },
                        childCount: list.length,
                      ),
                    ),
                  );
                },
                loading: () => const _LoadingGrid(),
                error: (e, _) => SliverToBoxAdapter(
                  child: Center(child: Text('Error: $e')),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MiniPlayer(),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (val) => ref.read(searchQueryProvider.notifier).state = val,
      decoration: InputDecoration(
        hintText: 'Search ambiences...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _AmbienceCard extends StatelessWidget {
  final dynamic ambience;
  const _AmbienceCard({required this.ambience});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailsScreen(ambience: ambience),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: 'image_${ambience.id}',
                    child: Image.asset(
                      ambience.thumbnailUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        ambience.tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ambience.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${ambience.durationMinutes} min session',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 c l a s s   _ L o a d i n g G r i d   e x t e n d s   S t a t e l e s s W i d g e t   { 
     c o n s t   _ L o a d i n g G r i d ( ) ; 
 
     @ o v e r r i d e 
     W i d g e t   b u i l d ( B u i l d C o n t e x t   c o n t e x t )   { 
         r e t u r n   S l i v e r P a d d i n g ( 
             p a d d i n g :   c o n s t   E d g e I n s e t s . s y m m e t r i c ( h o r i z o n t a l :   2 0 ) , 
             s l i v e r :   S l i v e r G r i d ( 
                 g r i d D e l e g a t e :   c o n s t   S l i v e r G r i d D e l e g a t e W i t h F i x e d C r o s s A x i s C o u n t ( 
                     c r o s s A x i s C o u n t :   2 , 
                     c h i l d A s p e c t R a t i o :   0 . 8 , 
                     c r o s s A x i s S p a c i n g :   1 6 , 
                     m a i n A x i s S p a c i n g :   1 6 , 
                 ) , 
                 d e l e g a t e :   S l i v e r C h i l d B u i l d e r D e l e g a t e ( 
                     ( c o n t e x t ,   i n d e x )   { 
                         r e t u r n   S h i m m e r . f r o m C o l o r s ( 
                             b a s e C o l o r :   C o l o r s . g r e y [ 3 0 0 ] ! , 
                             h i g h l i g h t C o l o r :   C o l o r s . g r e y [ 1 0 0 ] ! , 
                             c h i l d :   C o n t a i n e r ( 
                                 d e c o r a t i o n :   B o x D e c o r a t i o n ( 
                                     c o l o r :   C o l o r s . w h i t e , 
                                     b o r d e r R a d i u s :   B o r d e r R a d i u s . c i r c u l a r ( 2 8 ) , 
                                 ) , 
                             ) , 
                         ) ; 
                     } , 
                     c h i l d C o u n t :   6 , 
                 ) , 
             ) , 
         ) ; 
     } 
 } 
  
 