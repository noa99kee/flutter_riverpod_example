abstract class PaginationState {}

class PaginationStateError extends PaginationState {}

class PaginationStateLoading extends PaginationState {}

class PaginationStateData<T> extends PaginationState {
  final List<T> data;
  PaginationStateData({
    required this.data,
  });
}
