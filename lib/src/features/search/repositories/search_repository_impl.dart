import 'dart:developer';

import 'package:it_project/src/features/search/remote/model/content_search.dart';
import 'package:it_project/src/features/search/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl({
    required super.searchService,
  });

  @override
  Future<List<ContentSearch>> searchContent(text) async {
    try {
      final responseSearchContent = await searchService.searchContent(text);

      final List<dynamic> items = responseSearchContent.data;
      final result = items.map((e) => ContentSearch.fromJson(e)).toList();

      return result;
    } catch (ex) {
      log(ex.toString());
      return [];
    }
  }
}
