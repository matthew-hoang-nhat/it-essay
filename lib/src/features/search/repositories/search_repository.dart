import 'package:it_project/src/features/search/remote/model/content_search.dart';
import 'package:it_project/src/features/search/remote/search_service.dart';

abstract class SearchRepository {
  final SearchService searchService;
  SearchRepository({required this.searchService});

  Future<List<ContentSearch>> searchContent(text);
}
