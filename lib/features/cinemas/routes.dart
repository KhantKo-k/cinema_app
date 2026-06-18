import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/features/cinemas/domain/entities/cinema_entity.dart';
import 'package:cinema_app/features/cinemas/presentation/pages/cinema_page.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@immutable
class CinemaPageArgs {
  final MovieEntity movie;
  final CinemaEntity cinema;
  final bool isBooking;

  const CinemaPageArgs({
    required this.movie,
    required this.cinema,
    required this.isBooking,
  });
}

class CinemasRoutes {
  static const String cinema = '/movies/:movieId/cinemas/:cinemaId';

  static final routes = <RouteBase>[
    GoRoute(
      path: cinema,
      builder: (context, state) {
        final args = state.extra as CinemaPageArgs?;
        if (args == null) {
          return const Scaffold(
            body: Center(child: Text('CinemaPageArgs is missing.')),
          );
        }

        return CinemaPage(
          movie: args.movie,
          cinema: args.cinema,
          isBooking:  args.isBooking,
        );
      },
    ),
  ];
}

extension CinemasRoutesExtension on AppRouter {
  void navigateToCinemaPage({
    required MovieEntity movie,
    required CinemaEntity cinema,
    required bool isBooking,
  }) {
    router.push(
      CinemasRoutes.cinema
          .replaceFirst(':movieId', movie.id!)
          .replaceFirst(':cinemaId', cinema.id ?? ''),
      extra: CinemaPageArgs(movie: movie, cinema: cinema,isBooking: isBooking),
    );
  }
}