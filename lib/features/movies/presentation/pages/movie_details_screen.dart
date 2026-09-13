import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/service_locator.dart' as di;
import '../../domain/entities/movie.dart';
import '../bloc/movie_details_cubit.dart';
import '../bloc/movie_details_state.dart';
import '../widgets/rating_badge.dart';

/// Bare-bones placeholder: wires up the data (details + suggestions) so the
/// real, designed screen can be built on top of it. Not the final UI.
class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<MovieDetailsCubit>(param1: movie)..loadDetails(),
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          final movie = state.initialMovie;
          final details = state.details;
          final backgroundImage = details?.backgroundImage ?? movie.backgroundImage;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColor.black,
                expandedHeight: 320,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColor.yellow),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                  background: backgroundImage != null
                      ? Image.network(
                          backgroundImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: AppColor.gray),
                        )
                      : Container(color: AppColor.gray),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.status == MovieDetailsStatus.loading)
                        const Center(child: CircularProgressIndicator(color: AppColor.yellow)),
                      if (state.status == MovieDetailsStatus.error)
                        Center(
                          child: Column(
                            children: [
                              Text(
                                state.errorMessage ?? 'Failed to load movie details',
                                style: const TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () => context.read<MovieDetailsCubit>().loadDetails(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      if (details != null) ...[
                        Row(
                          children: [
                            RatingBadge(rating: details.rating ?? 0),
                            const SizedBox(width: 12),
                            Text(
                              '${details.runtime ?? 0} min',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.favorite, color: AppColor.red, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${details.likeCount}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        if (details.summary != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            details.summary!,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                        if (details.screenshots.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          const Text('Screenshots', style: TextStyle(color: Colors.white, fontSize: 18)),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: details.screenshots.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    details.screenshots[index],
                                    width: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(width: 200, color: AppColor.gray),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                      if (state.suggestions.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text('You may also like', style: TextStyle(color: Colors.white, fontSize: 18)),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.suggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion = state.suggestions[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MovieDetailsScreen(movie: suggestion),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      suggestion.mediumCoverImage ?? '',
                                      width: 110,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Container(width: 110, color: AppColor.gray),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
