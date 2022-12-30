import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final helloWorldProvider = Provider<String>(
  (ref) => 'Hello world',
);

final dateFormatterProvider = Provider<DateFormat>(
  (ref) {
    return DateFormat.MMMEd();
  },
);

class ProviderWidget extends ConsumerWidget {
  const ProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = ref.watch(dateFormatterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Provider')),
      body: Center(child: Text(formatter.format(DateTime.now()))),
    );
  }
}
