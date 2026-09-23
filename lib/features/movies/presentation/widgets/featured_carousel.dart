import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../pages/movie_details_screen.dart';
import '../../../../core/widgets/rating_badge.dart';

class FeaturedCarousel extends StatefulWidget {
  final List<Movie> movies;
  final Function(int) onPageChanged;

  const FeaturedCarousel({
    super.key,
    required this.movies,
    required this.onPageChanged,
  });

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.movies.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          widget.onPageChanged(index);
        },
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          final isCenter = index == _currentPage;
          
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie)),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: isCenter ? 0 : 40,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.largeCoverImage ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: RatingBadge(rating: movie.rating ?? 0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
