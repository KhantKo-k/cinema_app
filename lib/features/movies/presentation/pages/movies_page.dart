import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/core/theme/theme_mode_provider.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:cinema_app/features/movies/presentation/pages/banner_carousel.dart';
import 'package:cinema_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:cinema_app/features/movies/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesPage extends ConsumerWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moiveAsync = ref.watch(moviesProvider);
    final upcomingAsync = ref.watch(upcomingMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeModeProviderProvider.notifier).toggleThemeMode();
            },
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerCarousel(),
            const SizedBox(height: 10),

            moiveAsync.when(
              data: (movies) => _buildMovieSection(
                title: "Now Showing",
                movies: movies,
                accentColor: AppColors.electricBlue,
                context: context,
              ),
              error: (e, _) => const SizedBox.shrink(),
              loading: () => const _SectionLoader(),
            ),

            const SizedBox(height: 20),

            upcomingAsync.when(
              data: (movies) => _buildMovieSection(
                title: "Upcoming Movies",
                movies: movies,
                accentColor: AppColors.red,
                isUpcoming: true,
                context: context,
              ),
              error: (e, _) => const SizedBox.shrink(),
              loading: () => const _SectionLoader(),
            ),

            const SizedBox(height: 40),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text("Throw Test Exception"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieSection({
    required String title,
    required List<MovieEntity> movies,
    required Color accentColor,
    bool isUpcoming = false,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(title, movies.length, accentColor, context),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  _openMovieDetail(movie);
                },
                child: AnimatedMovieCard(
                  key: ValueKey("${movie.id}_$isUpcoming"),
                  index: index,
                  title: movie.title,
                  poster: movie.posterUrl,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    String title,
    int count,
    Color accentColor,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor.withOpacity(0.45), Colors.transparent],
              ),
            ),
          ),

          Row(
            children: [
              Container(
                width: 3,
                height: 20,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.8),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0, // Wide spacing for that "Theater" look
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              const SizedBox(width: 12),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    _PulsingDot(accentColor: accentColor),
                    const SizedBox(width: 6),
                    Text(
                      "$count MOVIES",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openMovieDetail(MovieEntity movie) {
    serviceLocator.get<AppRouter>().navigateToMovieDetail(movie);
  }
}

class _SectionLoader extends StatelessWidget {
  const _SectionLoader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: 3,
            itemBuilder: (context, index) => Container(
              width: 150,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color accentColor;
  const _PulsingDot({required this.accentColor});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1.0).animate(_controller),
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: widget.accentColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class AnimatedMovieCard extends StatefulWidget {
  final int index;
  final String title;
  final String poster;

  const AnimatedMovieCard({
    super.key,
    required this.index,
    required this.title,
    required this.poster,
  });

  @override
  State<AnimatedMovieCard> createState() => _AnimatedMovieCardState();
}

class _AnimatedMovieCardState extends State<AnimatedMovieCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5)),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.4, 0),
      end: Offset.zero,
    ).animate(curvedAnimation);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(curvedAnimation);

    // Stagger delay capped at 600ms so items far down the list don't wait forever
    final delay = (widget.index * 100).clamp(0, 600);

    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.poster,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: const Color(
                                0xFF1A1C1E,
                              ), // Slate/Cool tone base
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 160,
                              color: const Color(0xFF1A1C1E),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.broken_image,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "No Poster",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
