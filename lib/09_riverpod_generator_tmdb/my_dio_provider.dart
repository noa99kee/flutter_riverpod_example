import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_dio_provider.g.dart';

@riverpod
Dio myDio(MyDioRef ref) {
  final dio = Dio();
  return dio;
}
