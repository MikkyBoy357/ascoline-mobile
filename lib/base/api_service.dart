import 'package:ascolin/base/constant.dart';
import 'package:ascolin/base/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final _dio = createDioInstance();

  static Dio createDioInstance() {
    var dio = Dio(
      BaseOptions(
        baseUrl: Constant.baseUrl,
      ),
    );

    final tokenDio = Dio();
    tokenDio.options = dio.options;

    // adding interceptor
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.path != "/auth/login" && options.path != "/auth/signup") {
            final token = await checkAndGetToken();

            options.headers['Authorization'] = "Bearer ${token?.token}";
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          /// Assume 401 stands for token expired
          if (error.response?.statusCode == 401) {
            if (kDebugMode) {
              print('the token has expired, need to receive new token');
            }
            final options = error.response!.requestOptions;

            final token = await refreshToken(tokenDio);

            options.headers['Authorization'] = "Bearer ${token?.token}";

            if (options.headers['Authorization'] != null) {
              if (kDebugMode) {
                print('the token has been updated');
              }

              /// since the api has no state, force to pass the 401 error
              /// by adding query parameter
              final originResult = await dio.fetch(options..path);
              if (originResult.statusCode != null &&
                  originResult.statusCode! ~/ 100 == 2) {
                return handler.resolve(originResult);
              }
            }
            if (kDebugMode) {
              print('the token has not been updated');
            }
            return handler.reject(
              DioException(requestOptions: options),
            );
          }
          return handler.next(error);
        },
      ),
    );
    return dio;
  }

  Dio get dio => _dio;
}
