import 'package:furmeetdev/data/api/endpoint.dart';
import 'package:furmeetdev/data/models/error_data.dart';
import 'package:furmeetdev/presentation/viewmodels/UserViewModel.dart';
import 'package:dio/dio.dart';

import 'package:furmeetdev/data/models/User.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class UserRepository {
  Future<dynamic> login(UserRequest req);
}

class UserRepositoryImpl implements UserRepository {
  late Dio _dio;

  UserRepositoryImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseURL,
        responseType: ResponseType.json,
      ),
    );
  }

  Future<dynamic> login(UserRequest request) async {
    try {
      final response =
          await _dio.post(Endpoints.loginURL, data: request.toJson());
      return UserResponse.fromJson(response.data);
    } on DioError catch (ex) {
      return ErrorResponse.fromJson(ex.response?.data);
    }
  }
}

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});