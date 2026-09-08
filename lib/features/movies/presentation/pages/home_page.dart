import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';
import '../bloc/movies_cubit.dart';
import '../bloc/movies_state.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/rating_badge.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state.status == MoviesStatus.loading && state.movies.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColor.yellow));
        }

        if (state.status == MoviesStatus.error && state.movies.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage ?? 'An error occurred', style: const TextStyle(color: Colors.white)),
                ElevatedButton(
                  onPressed: () => context.read<MoviesCubit>().loadMovies(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final featuredMovie = state.movies.isNotEmpty ? state.movies[state.selectedFeaturedIndex] : null;

        return RefreshIndicator(
          onRefresh: () => context.read<MoviesCubit>().refresh(),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                if (featuredMovie != null)
                  Container(
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(featuredMovie.backgroundImage ?? ''),
                        fit: BoxFit.cover,
                        opacity: 0.3,
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black],
                        ),
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.availableNow,
                        height: 90,
                      ),
                      const SizedBox(height: 10),
                      if (state.movies.isNotEmpty)
                        FeaturedCarousel(
                          movies: state.movies.take(10).toList(),
                          onPageChanged: (index) {
                            context.read<MoviesCubit>().updateSelectedFeaturedIndex(index);
                          },
                        ),
                      const SizedBox(height: 20),
                      Image.asset(
                        AppAssets.watchNow,
                        height: 90,
                      ),
                      const SizedBox(height: 10),
                      _buildMoviesSection(context, 'Action', state.actionMovies),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoviesSection(BuildContext context, String title, List<dynamic> moviesList) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'See More →',
                style: TextStyle(color: AppColor.yellow, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: moviesList.length,
            itemBuilder: (context, index) {
              final movie = moviesList[index];
              return Container(
                width: 130,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie.mediumCoverImage ?? '',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: RatingBadge(rating: movie.rating ?? 0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
