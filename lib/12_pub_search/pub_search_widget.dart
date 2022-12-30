import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_example/12_pub_search/detail.dart';
import 'package:riverpod_example/12_pub_search/pub_repository.dart';
import 'package:riverpod_example/12_pub_search/ui/appbar.dart';
import 'package:riverpod_example/12_pub_search/ui/package_item.dart';
import 'package:riverpod_example/12_pub_search/ui/searchbar.dart';

part 'pub_search_widget.g.dart';

const packagesPackageSize = 100;
const searchPageSize = 10;

@riverpod
Future<List<Package>> fetchPackages(
  FetchPackagesRef ref, {
  required int page,
  String search = '',
}) async {
  assert(page > 0, 'page offset starts at 1');
  final cancelToken = ref.cancelToken();

  if (search.isEmpty) {
    return ref
        .watch(pubRepositoryProvider)
        .getPackages(page: page, cancelToken: cancelToken);
  }

  // Debouncing searches by delaying the request.
  // If the search was cancelled during this delay, the network request will
  // not be performed.
  await Future<void>.delayed(const Duration(milliseconds: 250));
  if (cancelToken.isCancelled) {
    throw Exception('cancelled');
  }

  final searchedPackages = await ref
      .watch(pubRepositoryProvider)
      .searchPackages(page: page, search: search, cancelToken: cancelToken);

  return Future.wait([
    for (final package in searchedPackages)
      ref.watch(
        FetchPackageDetailsProvider(packageName: package.package).future,
      ),
  ]);
}

class PubSearchWidget extends HookConsumerWidget {
  const PubSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    useListenable(searchController);

    return Scaffold(
      appBar: const PubAppbar(),
      body: Column(
        children: [
          SearchBar(controller: searchController),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                // disposes the pages previously fetched. Next read will refresh them
                ref.invalidate(fetchPackagesProvider);
                // keep showing the progress indicator until the first page is fetched
                // AsyncValue의 future에 접근 하는 방법
                return ref.read(
                  fetchPackagesProvider(page: 1, search: searchController.text)
                      .future,
                );
              },
              child: ListView.custom(
                padding: const EdgeInsets.only(top: 30),
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  final pageSize = searchController.text.isEmpty
                      ? packagesPackageSize
                      : searchPageSize;

                  final page = index ~/ pageSize +
                      1; //     ~/ 몫을 구하는 연산자, % 나머지를 구하는 연산자
                  final indexInPage = index % pageSize;
                  final packageList = ref.watch(
                    fetchPackagesProvider(
                      page: page,
                      search: searchController.text,
                    ),
                  );

                  return packageList.when(
                    error: (err, stack) => Text('Error $err'),
                    loading: () => const PackageItemShimmer(),
                    data: (packages) {
                      if (indexInPage >= packages.length) return null;

                      final package = packages[indexInPage];

                      return PackageItem(
                        name: package.name,
                        description: package.latest.pubspec.description,
                        version: package.latest.version,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) {
                              return PackageDetailPage(
                                packageName: package.name,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
