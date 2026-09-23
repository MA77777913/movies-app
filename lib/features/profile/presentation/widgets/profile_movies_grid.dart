import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../movies/presentation/pages/movie_details_screen.dart';
import '../../../movies/presentation/widgets/rating_badge.dart';

/// Preliminary design: three covers per row, rating in the corner.
class ProfileMoviesGrid extends StatelessWidget {
  final List<Movie> movies;

  const ProfileMoviesGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Image.asset(
          AppAssets.empty,
          width: 124,
          height: 124,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie)),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  movie.mediumCoverImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: AppColor.gray),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: RatingBadge(rating: movie.rating ?? 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
