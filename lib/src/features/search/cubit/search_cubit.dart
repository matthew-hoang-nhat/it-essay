import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
      : super(const SearchInitial(
          contentSearches: [],
          categories: [],
          isLoading: false,
          // isEmpty: true,
          // isShowProducts: false,
        ));

  final SearchRepository _searchRepository = getIt<SearchRepositoryImpl>();

  searchContent(String text) async {
    final searchContentsResponse = await _searchRepository.searchContent(text);
    if (searchContentsResponse.isSuccess) {
      final contentSearches = searchContentsResponse.data;
      emit(state.copyWith(contentSearches: contentSearches));
      return;
    }
  }

  @override
  void emit(SearchState state) {
    if (isClosed) return;
    super.emit(state);
  }
}
