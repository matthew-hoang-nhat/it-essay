// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_review_cubit.dart';

class CreateReviewState extends Equatable {
  const CreateReviewState({
    required this.isLoading,
    required this.ratingNumber,
    required this.attaches,
    required this.productId,
  });
  final bool isLoading;
  final double ratingNumber;
  final String productId;
  final List<Attach> attaches;

  @override
  List<Object> get props => [
        isLoading,
        ratingNumber,
        attaches,
      ];

  CreateReviewState copyWith({
    bool? isLoading,
    double? ratingNumber,
    String? productId,
    List<Attach>? attaches,
  }) {
    return CreateReviewState(
      isLoading: isLoading ?? this.isLoading,
      productId: productId ?? this.productId,
      ratingNumber: ratingNumber ?? this.ratingNumber,
      attaches: attaches ?? this.attaches,
    );
  }
}

class CreateReviewInitial extends CreateReviewState {
  const CreateReviewInitial({
    required super.productId,
    required super.isLoading,
    required super.ratingNumber,
    required super.attaches,
  });
}
