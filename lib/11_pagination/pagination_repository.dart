import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/11_pagination/pagination_model.dart';
import 'package:riverpod_example/11_pagination/pagination_state.dart';

abstract class IBasePaginationRepository<T extends IModelWithID> {
  Future<PaginationStateData<T>> getPageData();
}

class IPhoneRepository implements IBasePaginationRepository<IPhoneModel> {
  @override
  Future<PaginationStateData<IPhoneModel>> getPageData() async {
    await Future.delayed(Duration(milliseconds: 1100));
    List<IPhoneModel> data = [
      IPhoneModel(id: '0', name: 'iPhone 12'),
      IPhoneModel(id: '1', name: 'iPhone SE'),
      IPhoneModel(id: '2', name: 'iPhone 13'),
      IPhoneModel(id: '3', name: 'iPhone 14'),
      IPhoneModel(id: '4', name: 'iPhone 14 Pro'),
    ];

    return PaginationStateData(data: data);
  }
}

class IPadRepository implements IBasePaginationRepository<IPadModel> {
  @override
  Future<PaginationStateData<IPadModel>> getPageData() async {
    await Future.delayed(Duration(milliseconds: 800));
    List<IPadModel> data = [
      IPadModel(id: '0', name: 'iPad Pro'),
      IPadModel(id: '1', name: 'iPad Air'),
      IPadModel(id: '2', name: 'iPad'),
      IPadModel(id: '3', name: 'iPad mini'),
    ];

    return PaginationStateData(data: data);
  }
}

class MacRepository implements IBasePaginationRepository<MacModel> {
  @override
  Future<PaginationStateData<MacModel>> getPageData() async {
    await Future.delayed(Duration(milliseconds: 600));
    List<MacModel> data = [
      MacModel(id: '0', name: 'MacBook Air'),
      MacModel(id: '1', name: 'MacBook Pro'),
      MacModel(id: '2', name: 'iMac 24'),
      MacModel(id: '3', name: 'Mac mini'),
      MacModel(id: '4', name: 'Mac Studio'),
      MacModel(id: '5', name: 'Mac Pro'),
    ];

    return PaginationStateData(data: data);
  }
}

final iPhoneRepositoryProvider = Provider<IPhoneRepository>(
  (ref) => IPhoneRepository(),
);

final iPadRepositoryProvider = Provider<IPadRepository>(
  (ref) => IPadRepository(),
);

final macRepositoryProvider = Provider<MacRepository>(
  (ref) => MacRepository(),
);
