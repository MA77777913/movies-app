import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/service_locator.dart' as di;
import '../../../../core/widgets/rating_badge.dart';
import '../../../movies/presentation/pages/movie_details_screen.dart';
import '../cubit/browse_cubit.dart';
import '../cubit/browse_state.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<BrowseCubit>()..loadMovies(),
      child: const _BrowseView(),
    );
  }
}

class _BrowseView extends StatelessWidget {
  const _BrowseView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Genre Chips Row
          BlocBuilder<BrowseCubit, BrowseState>(
            buildWhen: (previous, current) =>
                previous.selectedGenre != current.selectedGenre ||
                previous.genres != current.genres,
            builder: (context, state) {
              if (state.genres.isEmpty) {
                return const SizedBox(height: 42);
              }
              return SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.genres.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final genre = state.genres[index];
                    final isSelected =
                        genre.toLowerCase() ==
                        state.selectedGenre.toLowerCase();

                    return GestureDetector(
                      onTap: () {
                        context.read<BrowseCubit>().selectGenre(genre);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.yellow
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColor.yellow, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            genre,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.black
                                  : AppColor.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Movies Grid
          Expanded(
            child: BlocBuilder<BrowseCubit, BrowseState>(
              builder: (context, state) {
                if (state.status == BrowseStatus.loading &&
                    state.allMovies.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.yellow),
                  );
                }

                if (state.status == BrowseStatus.error &&
                    state.allMovies.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage ?? 'Failed to load movies',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.yellow,
                          ),
                          onPressed: () =>
                              context.read<BrowseCubit>().loadMovies(),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final filteredMovies = state.filteredMovies;

                if (filteredMovies.isEmpty) {
                  return const Center(
                    child: Text(
                      'No movies found',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.67,
                  ),
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    final movie = filteredMovies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailsScreen(movie: movie),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              movie.mediumCoverImage ??
                                  movie.largeCoverImage ??
                                  '',
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
