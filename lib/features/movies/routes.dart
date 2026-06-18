
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:cinema_app/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:cinema_app/features/movies/presentation/pages/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesRoutes{
  static const String movies = '/movies';
  static const String movieDetail = '/movies/:movieId';

  static final shellRoutes = [
     GoRoute(
      path: movies,
      builder: (context, state){
        return MoviesPage();
      }
    )
  ];

  static final routes = [
    GoRoute(path: movieDetail,
    builder: (context, state) {
      final movie = state.extra as MovieEntity?;

      if(movie == null){
        return const Scaffold(body: Center(child: Text("Movie not found")));
      }

      return MovieDetailPage(movie: movie);
    },
    )
  ];
}

extension MoviesRoutesExtension on AppRouter{
  void navigateToMovies(){
    router.go(MoviesRoutes.movies);
  }

  void navigateToMovieDetail(MovieEntity movie){
    router.push(
      MoviesRoutes.movieDetail.replaceFirst(':movieId', movie.id!),
      extra: movie,
    );
  }
}