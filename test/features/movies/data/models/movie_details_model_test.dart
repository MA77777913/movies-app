import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/movies/data/models/movie_details_model.dart';

void main() {
  group('MovieDetailsResponseModel.fromJson', () {
    test('parses a real movie_details.json payload (with screenshots)', () {
      final json = jsonDecode(_detailsWithImagesJson);
      final response = MovieDetailsResponseModel.fromJson(json);

      final movie = response.data.movie;
      expect(movie.id, 78513);
      expect(movie.title, 'A Modest Killing');
      expect(movie.rating, 8.6);
      expect(movie.runtime, 82);
      expect(movie.genres, ['Drama']);
      expect(movie.likeCount, 1);

      final entity = movie.toEntity();
      expect(entity.likeCount, 1);
      expect(entity.runtime, 82);
      // Large screenshots are present, so they should be preferred over medium.
      expect(entity.screenshots, [
        'https://yts.gg/assets/images/movies/a_modest_killing_2026/large-screenshot1.jpg',
        'https://yts.gg/assets/images/movies/a_modest_killing_2026/large-screenshot2.jpg',
        'https://yts.gg/assets/images/movies/a_modest_killing_2026/large-screenshot3.jpg',
      ]);
    });

    test('falls back to medium screenshots when large ones are absent', () {
      final json = jsonDecode(_detailsMediumOnlyJson);
      final response = MovieDetailsResponseModel.fromJson(json);
      final entity = response.data.movie.toEntity();

      expect(entity.screenshots, [
        'https://example.com/medium1.jpg',
        'https://example.com/medium2.jpg',
      ]);
    });

    test('defaults likeCount to 0 and screenshots to empty when both are absent', () {
      final json = jsonDecode(_detailsMinimalJson);
      final response = MovieDetailsResponseModel.fromJson(json);
      final entity = response.data.movie.toEntity();

      expect(entity.likeCount, 0);
      expect(entity.screenshots, isEmpty);
      expect(entity.rating, isNull);
      expect(entity.runtime, isNull);
    });
  });
}

// Real payload captured from https://yts.gg/api/v2/movie_details.json?movie_id=78513&with_images=true
const _detailsWithImagesJson = '''
{"status":"ok","status_message":"Query was successful.","data":{"movie":{"id":78513,"url":"https://yts.gg/movies/a-modest-killing-2026","imdb_code":"tt41340331","title":"A Modest Killing","title_english":"A Modest Killing","title_long":"A Modest Killing (2026)","slug":"a-modest-killing-2026","year":2026,"rating":8.6,"runtime":82,"genres":["Drama"],"like_count":1,"description_intro":"Young lovers turn on one another in the aftermath of a deadly car crash.","description_full":"Young lovers turn on one another in the aftermath of a deadly car crash.","yt_trailer_code":"","language":"eng","mpa_rating":"","background_image":"https://yts.gg/assets/images/movies/a_modest_killing_2026/background.jpg","background_image_original":"https://yts.gg/assets/images/movies/a_modest_killing_2026/background.jpg","small_cover_image":"https://yts.gg/assets/images/movies/a_modest_killing_2026/small-cover.jpg","medium_cover_image":"https://yts.gg/assets/images/movies/a_modest_killing_2026/medium-cover.jpg","large_cover_image":"https://yts.gg/assets/images/movies/a_modest_killing_2026/large-cover.jpg","medium_screenshot_image1":"https://yts.gg/assets/images/movies/a_modest_killing_2026/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.gg/assets/images/movies/a_modest_killing_2026/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.gg/assets/images/movies/a_modest_killing_2026/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.gg/assets/images/movies/a_modest_killing_2026/large-screenshot1.jpg","large_screenshot_image2":"https://yts.gg/assets/images/movies/a_modest_killing_2026/large-screenshot2.jpg","large_screenshot_image3":"https://yts.gg/assets/images/movies/a_modest_killing_2026/large-screenshot3.jpg","date_uploaded":"2026-09-13 03:06:33","date_uploaded_unix":1789261593}}}
''';

const _detailsMediumOnlyJson = '''
{"status":"ok","status_message":"ok","data":{"movie":{"id":1,"title":"Medium Only","medium_screenshot_image1":"https://example.com/medium1.jpg","medium_screenshot_image2":"https://example.com/medium2.jpg"}}}
''';

const _detailsMinimalJson = '''
{"status":"ok","status_message":"ok","data":{"movie":{"id":2,"title":"Bare Minimum"}}}
''';
