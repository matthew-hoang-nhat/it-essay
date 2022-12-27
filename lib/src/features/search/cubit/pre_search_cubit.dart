import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';

part 'pre_search_state.dart';

enum PreSearchCubitEnum { searchText }

class PreSearchCubit extends Cubit<PreSearchState> {
  PreSearchCubit()
      : super(const PreSearchInitial(
          contentSearches: [],
        ));

  Timer? _debounce;
  TextEditingController searchController = TextEditingController();

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        _searchContent(searchController.text);
      }
    });
  }

  Future _searchContent(String text) async {
    final searchContentsResponse = await _searchRepo.searchContent(text);
    if (searchContentsResponse.isSuccess) {
      final contentSearches = searchContentsResponse.data;
      emit(state.copyWith(contentSearches: contentSearches));
      return;
    }
  }

  final SearchRepository _searchRepo = getIt<SearchRepositoryImpl>();

  setField(PreSearchCubitEnum key, {value}) {
    switch (key) {
      case PreSearchCubitEnum.searchText:
        searchController.text = value;
        break;
      default:
    }
  }
}
