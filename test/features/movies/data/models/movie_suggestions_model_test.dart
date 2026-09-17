import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/movies/data/models/movie_model.dart';

void main() {
  group('MovieResponseModel.fromJson (movie_suggestions.json)', () {
    test('parses a real movie_suggestions.json payload into Movie entities', () {
      final json = jsonDecode(_suggestionsJson);
      final response = MovieResponseModel.fromJson(json);

      expect(response.data.movies, hasLength(2));

      final entities = response.data.movies!.map((m) => m.toEntity()).toList();
      expect(entities[0].id, 1768);
      expect(entities[0].title, 'Killing Jesus');
      expect(entities[0].rating, 4.7);
      expect(entities[1].id, 1769);
      expect(entities[1].title, 'Killing Season');
    });

    test('maps to an empty list when the movies key is absent', () {
      final json = jsonDecode(_emptySuggestionsJson);
      final response = MovieResponseModel.fromJson(json);

      expect(response.data.movies, isNull);
      expect(response.data.movies?.map((m) => m.toEntity()).toList() ?? [], isEmpty);
    });
  });
}

// Real payload captured from https://yts.gg/api/v2/movie_suggestions.json?movie_id=78513
const _suggestionsJson = '''
{"status":"ok","status_message":"ok","data":{"movie_count":0,"movies":[{"id":1768,"url":"https://yts.gg/movies/killing-jesus-2015","imdb_code":"tt3609402","title":"Killing Jesus","title_english":"Killing Jesus","title_long":"Killing Jesus (2015)","slug":"killing-jesus-2015","year":2015,"rating":4.7,"runtime":132,"genres":["Action","Biography","Drama","History"],"summary":"A TV Movie chronicling the life of Jesus of Nazareth.","background_image":"https://yts.gg/assets/images/movies/killing_jesus_2015/background.jpg","medium_cover_image":"https://yts.gg/assets/images/movies/killing_jesus_2015/medium-cover.jpg"},{"id":1769,"url":"https://yts.gg/movies/killing-season-2013","imdb_code":"tt1480295","title":"Killing Season","title_english":"Killing Season","title_long":"Killing Season (2013)","slug":"killing-season-2013","year":2013,"rating":5.4,"runtime":91,"genres":["Action","Drama","Thriller"],"summary":"Two veterans of the Bosnian War.","background_image":"https://yts.gg/assets/images/movies/Killing_Season_2013/background.jpg","medium_cover_image":"https://yts.gg/assets/images/movies/Killing_Season_2013/medium-cover.jpg"}]}}
''';

const _emptySuggestionsJson = '''
{"status":"ok","status_message":"ok","data":{"movie_count":0,"limit":20,"page_number":1}}
''';
