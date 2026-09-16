import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_text_style.dart';
import 'package:movies_app/features/auth/presentation/widgets/login_widgets/custom_button.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/service_locator.dart' as di;
import '../../domain/entities/movie.dart';
import '../bloc/movie_details_cubit.dart';
import '../bloc/movie_details_state.dart';
import '../widgets/additional_details.dart';
import '../widgets/cast_card.dart';
import '../widgets/genres_wrap.dart';
import '../widgets/similar_movies_grid.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<MovieDetailsCubit>(param1: movie)..loadDetails(),
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

          // `details` is null until the API responds, so everything in the
          // header falls back to the movie we were handed on tap.
          final backgroundImage =
              details?.backgroundImage ?? movie.backgroundImage;
          final year = details?.year ?? movie.year;
          final runtime = details?.runtime ?? movie.runtime;
          final rating = details?.rating ?? movie.rating;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 645,
                  decoration: BoxDecoration(
                    color: AppColor.gray,
                    image: backgroundImage != null && backgroundImage.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(backgroundImage),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 28),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColor.white,
                                    size: 29,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const Icon(
                                  Icons.bookmark_outlined,
                                  color: AppColor.white,
                                  size: 29,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/image/play_btn.png"),
                        ),
                      ),
                      Column(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                movie.title,
                                style: AppTextStyle.titleMovieDetails,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                year?.toString() ?? '',
                                style: AppTextStyle.titleMovieDetailsDate,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    onPressed: () {},
                    text: "Watch",
                    backgroundColor: AppColor.red,
                    textColor: AppColor.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalDetails(
                        iconPath: "assets/movieDetailsAssets/like.png",
                        likeCount: details?.likeCount.toString() ?? '-',
                      ),
                      AdditionalDetails(
                        iconPath: "assets/movieDetailsAssets/time.png",
                        likeCount: runtime?.toString() ?? '-',
                      ),
                      AdditionalDetails(
                        iconPath: "assets/movieDetailsAssets/star.png",
                        likeCount: rating?.toString() ?? '-',
                      ),
                    ],
                  ),
                ),
                _DetailsSections(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Everything below the header needs the API response, so it waits for it.
class _DetailsSections extends StatelessWidget {
  final MovieDetailsState state;

  const _DetailsSections({required this.state});

  @override
  Widget build(BuildContext context) {
    final details = state.details;

    if (details == null) {
      if (state.status == MovieDetailsStatus.error) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                state.errorMessage ?? 'Failed to load movie details',
                style: AppTextStyle.normalTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.read<MovieDetailsCubit>().loadDetails(),
                child: Text('Retry', style: AppTextStyle.appBarTxtStyle),
              ),
            ],
          ),
        );
      }
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: CircularProgressIndicator(color: AppColor.yellow)),
      );
    }

    final summary = details.descriptionFull?.isNotEmpty == true
        ? details.descriptionFull!
        : (details.summary ?? '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (details.screenshots.isNotEmpty) ...[
            const _SectionTitle("Screen Shots"),
            for (final screenshot in details.screenshots)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 167,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(screenshot),
                      fit: BoxFit.cover,
                    ),
                    color: AppColor.gray,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
          ],
          if (state.suggestions.isNotEmpty) ...[
            const _SectionTitle("Similar"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimilarMoviesGrid(movies: state.suggestions),
            ),
          ],
          if (summary.isNotEmpty) ...[
            const _SectionTitle("Summary"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(summary, style: AppTextStyle.sumaryTextStyle),
            ),
          ],
          if (details.cast.isNotEmpty) ...[
            const _SectionTitle("Cast"),
            for (final member in details.cast)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CastCard(member: member),
              ),
          ],
          if (details.genres?.isNotEmpty == true) ...[
            const _SectionTitle("Genres"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GenresWrap(genres: details.genres!),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(title, style: AppTextStyle.titleMovieDetails),
      ),
    );
  }
}
