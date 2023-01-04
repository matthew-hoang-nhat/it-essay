part of 'pre_search_cubit.dart';

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

class PreSearchState extends Equatable {
  const PreSearchState({
    required this.contentSearches,
  });
  final List<ContentSearch> contentSearches;

  @override
  List<Object?> get props => [
        contentSearches,
      ];

  PreSearchState copyWith({
    List<ContentSearch>? contentSearches,
  }) {
    return PreSearchState(
      contentSearches: contentSearches ?? this.contentSearches,
    );
  }
}

class PreSearchInitial extends PreSearchState {
  const PreSearchInitial({
    required super.contentSearches,
  });
}
