import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../../movies/presentation/bloc/movies_cubit.dart';
import '../../../movies/presentation/bloc/movies_state.dart';
import '../../../movies/presentation/pages/movie_details_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColor.gray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) {
                  setState(() {});
                },
                style: const TextStyle(color: AppColor.white, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Icons.search, color: AppColor.white, size: 24),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                if (state.status == MoviesStatus.loading && state.movies.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.yellow),
                  );
                }

                final searchQuery = _searchController.text.trim().toLowerCase();
                final filteredMovies = searchQuery.isEmpty
                    ? state.movies
                    : state.movies.where((movie) {
                        return movie.title.toLowerCase().contains(searchQuery);
                      }).toList();

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
                              movie.mediumCoverImage ?? movie.largeCoverImage ?? '',
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
