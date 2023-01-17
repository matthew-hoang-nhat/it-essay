import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl({
    required super.searchService,
  });

  @override
  Future<FResult<List<ContentSearch>>> searchContent(text) async {
    try {
      final responseSearchContent = await searchService.searchContent(text);

      final List<dynamic> items = responseSearchContent.data;
      final result = items.map((e) => ContentSearch.fromJson(e)).toList();

      return FResult.success(result);
    } catch (ex) {
      if (ex is DioError) {
        log(ex.error.toString());
      }

      return FResult.error(ex.toString());
    }
  }
}
