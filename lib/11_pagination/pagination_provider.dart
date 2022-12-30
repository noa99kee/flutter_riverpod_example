import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/11_pagination/pagination_model.dart';
import 'package:riverpod_example/11_pagination/pagination_repository.dart';
import 'package:riverpod_example/11_pagination/pagination_state.dart';

class PaginationStateNotifier<T extends IModelWithID,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<PaginationState> {
  final U repository;

  PaginationStateNotifier({required this.repository})
      : super(PaginationStateLoading()) {
    getPageData();
  }

  Future<void> getPageData() async {
    state = PaginationStateLoading();
    try {
      state = await repository.getPageData();
    } catch (e, st) {
      state = PaginationStateError();
    }
  }
}

final iPhoneProvider =
    AutoDisposeStateNotifierProvider<PaginationStateNotifier, PaginationState>(
  (ref) {
    final repository = ref.watch(iPhoneRepositoryProvider);
    return PaginationStateNotifier(repository: repository);
  },
);

final iPadProvider =
    AutoDisposeStateNotifierProvider<PaginationStateNotifier, PaginationState>(
  (ref) {
    final repository = ref.watch(iPadRepositoryProvider);
    return PaginationStateNotifier(repository: repository);
  },
);
final macProvider =
    AutoDisposeStateNotifierProvider<PaginationStateNotifier, PaginationState>(
  (ref) {
    final repository = ref.watch(macRepositoryProvider);
    return PaginationStateNotifier(repository: repository);
  },
);
