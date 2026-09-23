import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../domain/entities/movie.dart';
import '../pages/movie_details_screen.dart';
import '../../../../core/widgets/rating_badge.dart';

/// Preliminary design: 2x2 grid of suggested movies. Restyle freely.
class SimilarMoviesGrid extends StatelessWidget {
  final List<Movie> movies;

  const SimilarMoviesGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    // The design calls for 4 (2 per row); the API may return fewer.
    final items = movies.take(4).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final movie = items[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie)),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  movie.mediumCoverImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppColor.gray),
                ),
                Positioned(
                  top: 8,
                  left: 8,
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
