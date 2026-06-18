import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/features/cinemas/domain/entities/cinema_entity.dart';
import 'package:cinema_app/features/cinemas/presentation/providers/cinema_providers.dart';
import 'package:cinema_app/features/cinemas/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import '../../domain/entities/movie_entity.dart';

class MovieDetailPage extends ConsumerWidget {
  final MovieEntity movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(movie.posterUrl, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: Colors.black.withOpacity(
                    0.55,
                  ), // blends nicely with dark theme
                ),
              ),
            ),
            CustomScrollView(
              slivers: [
                _buildSliverAppBar(context),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          _buildTitleAndRating(colorScheme),
                          const SizedBox(height: 24),
                          _buildGlassStatsGrid(colorScheme),
                          const SizedBox(height: 24),
                          _buildSectionHeader(colorScheme, "GENRE"),
                          _buildGenreScroll(colorScheme),
                          const SizedBox(height: 24),
                          _buildSectionHeader(colorScheme, "STORYLINE"),
                          Text(
                            movie.description,
                            style: TextStyle(
                              color: colorScheme.onSurface.withOpacity(
                                0.7,
                              ), // Responsive
                              height: 1.6,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildSectionHeader(colorScheme, "CAST"),
                          _buildCastList(colorScheme), // New widget call
                          const SizedBox(height: 24),
                          _buildSectionHeader(colorScheme, "DIRECTOR"),
                          _buildDirectorSection(colorScheme),
                          const SizedBox(height: 24),
                          _buildSectionHeader(colorScheme, "CINEMAS LIST"),
                          _buildCinemaList(ref, colorScheme),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassStatsGrid(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withOpacity(0.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            colorScheme,
            Icons.movie_filter_rounded,
            "STATUS",
            movie.status.toUpperCase(),
          ),
          _buildVerticalDivider(colorScheme),
          _buildStatItem(
            colorScheme,
            Icons.closed_caption_rounded,
            "SUBTITLES",
            movie.subtitles,
          ),
          _buildVerticalDivider(colorScheme),
          _buildStatItem(
            colorScheme,
            Icons.access_time_filled_rounded,
            "RUNTIME",
            "${movie.duration}m",
          ),
        ],
      ),
    );
  }

  Widget _buildCastList(ColorScheme colorScheme) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movie.cast.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final actor = movie.cast[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorScheme.onSurface.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xFF478ED1).withOpacity(0.2),
                  child: Text(
                    actor[0].toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF478ED1),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  actor,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(
    ColorScheme colorScheme,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(icon, color: AppColors.electricBlue.withOpacity(0.9), size: 25),
        const SizedBox(height: 8),

        Text(
          label,
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.4),
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),

        Text(
          value,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(ColorScheme colorScheme) {
    return Container(
      height: 30,
      width: 1,
      color: colorScheme.onSurface.withOpacity(0.3),
    );
  }

  Widget _buildDirectorSection(ColorScheme colorScheme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.onSurface.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.onSurface.withOpacity(0.12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_rounded, size: 18, color: colorScheme.primary),
            const SizedBox(width: 12),
            Text(
              movie.director,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 450,
      pinned: true,
      stretch: true,
      backgroundColor: colorScheme.surface,
      iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: colorScheme.surface.withOpacity(0.5),
          child: BackButton(color: colorScheme.onSurface),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Hero(
          tag: movie.id ?? '',
          child: Image.network(movie.posterUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildTitleAndRating(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            movie.title.toUpperCase(),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: colorScheme.onSurface,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            movie.rating,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ), // Rating stays amber/black
        ),
      ],
    );
  }

  Widget _buildGenreScroll(ColorScheme colorScheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: movie.genre
            .map(
              (g) => Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF478ED1),
                  ), // Keep blue accent
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  g,
                  style: TextStyle(
                    color: Color(0xFF478ED1),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSectionHeader(ColorScheme colorScheme, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.4),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildCinemaList(WidgetRef ref, ColorScheme colorScheme) {
    final cinemaAsync = ref.watch(cinemasProvider(movie.id!));
    return cinemaAsync.when(
      data: (cinemas) {
        if (cinemas.isEmpty) {
          return _buildNoShowtimesState(colorScheme);
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 6),
          itemCount: cinemas.length,

          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final cinema = cinemas[index];
            return _buildCinemaCard(cinema, colorScheme);
          },
        );
      },
      error: (error, _) =>
          Center(child: Text("Failed to load cinemas: $error")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildNoShowtimesState(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons
                .confirmation_number_outlined, // More "movie" specific than a location icon
            size: 40,
            color: colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No Showtimes Available",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "This movie isn't currently showing in any nearby cinemas. Check back later or try a different movie.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCinemaCard(CinemaEntity cinema, ColorScheme colorScheme) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        //border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                cinema.cinemaUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, _, __) => Container(
                  width: 85,
                  height: 85,
                  color: colorScheme.surfaceVariant,
                  child: const Icon(Icons.movie_creation_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cinema.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        cinema.location,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _actionButton(
                      "Book",
                      colorScheme,
                      onTap: () {
                        serviceLocator.get<AppRouter>().navigateToCinemaPage(
                          movie: movie,
                          cinema: cinema,
                          isBooking: true
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _actionButton(
                      "Buy",
                      colorScheme,
                      onTap: () {
                        serviceLocator.get<AppRouter>().navigateToCinemaPage(
                          movie: movie,
                          cinema: cinema,
                          isBooking:  false,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String label,
    ColorScheme colorScheme, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 90,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withOpacity(0.1),
          borderRadius: BorderRadius.circular(80),
          border: Border.all(color: colorScheme.primary.withOpacity(0.8)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
