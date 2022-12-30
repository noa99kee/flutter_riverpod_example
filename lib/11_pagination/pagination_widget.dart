import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/11_pagination/pagination_model.dart';
import 'package:riverpod_example/11_pagination/pagination_provider.dart';
import 'package:riverpod_example/11_pagination/pagination_state.dart';

class PaginationWidget extends ConsumerWidget {
  const PaginationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagination')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PaginationListView<IPhoneModel>(
            provider: iPhoneProvider,
            itemBuilder: (context, index, model) {
              //model 은 IPhoneModel
              return Text(
                'model id : ${model.id}   name : ${model.name}',
                style: TextStyle(fontSize: 24),
              );
            },
          ),
          PaginationListView<IPadModel>(
            provider: iPadProvider,
            itemBuilder: (context, index, model) {
              //model 은 IPadModel
              return Text(
                'model id : ${model.id}   name : ${model.name}',
                style: TextStyle(fontSize: 24),
              );
            },
          ),
          PaginationListView<MacModel>(
            provider: macProvider,
            itemBuilder: (context, index, model) {
              //model 은 MacModel
              return Text(
                'model id : ${model.id}   name : ${model.name}',
                style: TextStyle(fontSize: 24),
              );
            },
          )
        ],
      ),
    );
  }
}

//ItemBuilder를 선언해 주면 밖에서 그릴걸 정의 해 줄수 있다(미리 형태에 맞춰서 준비 한다.)
typedef ItemBuilder<T extends IModelWithID> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithID> extends ConsumerWidget {
  final AutoDisposeStateNotifierProvider<PaginationStateNotifier,
      PaginationState> provider;
  final ItemBuilder<T> itemBuilder;

  PaginationListView({
    required this.provider,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    if (state is PaginationStateLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is PaginationStateError) {
      return Center(
        child: Text('error'),
      );
    }

    final paginationState = state as PaginationStateData<T>;
    final products = paginationState.data;

    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        final product = products[index];
        /* 이러면 product 타입을 런타임에만 알기 때문에 model.name이 보이지 않음
        return Text(
          'model id : ${model.id}   name : ${model.name}',
          style: TextStyle(fontSize: 24),
        );
        */
        return itemBuilder(context, index, product);
      }),
    );
  }
}
