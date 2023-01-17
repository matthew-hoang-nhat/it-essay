import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/remote/services/search/search_service.dart';

abstract class SearchRepository {
  final SearchService searchService;
  SearchRepository({required this.searchService});

  Future<FResult<List<ContentSearch>>> searchContent(text);
}
