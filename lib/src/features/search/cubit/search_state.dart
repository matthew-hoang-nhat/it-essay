part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState({
    required this.contentSearches,
    required this.categories,
    required this.isLoading,
    required this.isEmpty,
  });
  final List<ContentSearch> contentSearches;
  final List<Category> categories;
  final bool isLoading;
  final bool isEmpty;
  @override
  List<Object> get props => [
        contentSearches,
        isLoading,
        isEmpty,
        categories,
      ];
}

class SearchInitial extends SearchState {
  const SearchInitial({
    required super.contentSearches,
    required super.isLoading,
    required super.isEmpty,
    required super.categories,
  });
}

class NewSearchState extends SearchState {
  NewSearchState.fromOldSettingState(
    SearchState oldState, {
    List<ContentSearch>? contentSearches,
    List<Category>? categories,
    bool? isLoading,
    bool? isEmpty,
  }) : super(
          contentSearches: contentSearches ?? oldState.contentSearches,
          isLoading: isLoading ?? oldState.isLoading,
          isEmpty: isEmpty ?? oldState.isEmpty,
          categories: categories ?? oldState.categories,
        );
}
