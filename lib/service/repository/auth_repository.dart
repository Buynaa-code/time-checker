import 'package:dio/dio.dart';
import 'package:time_checker/components/constant.dart';
import 'package:time_checker/service/model/member_model.dart';

import 'package:time_checker/service/network/netword_info.dart';
import 'package:time_checker/service/repository/repository.dart';
import 'package:time_checker/service/network/api_service.dart';

class RepositoryImpl extends Repository {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
    this._apiService,
    this._networkInfo,
  );
  @override
  Future<List<Member>> getMemberService() async {
    try {
      final response = await _apiService.get(endPoint: '/mobile-jagsaalt');

      // JSON өгөгдлийг бүхэлд нь хэвлэх
      loggerPretty.e('Response Data: ${response.data}');

      // `data` нь List эсэхийг шалгах
      if (response.data is List) {
        return (response.data as List).map((e) {
          try {
            return Member.fromJson(e);
          } catch (error) {
            loggerPretty.e('Error parsing member: $error | Data: $e');
            rethrow;
          }
        }).toList();
      } else {
        throw Exception(
            "Invalid data format: Expected a List but got ${response.data['data'].runtimeType}");
      }
    } catch (error) {
      loggerPretty.e('get members error: $error');
      if (error is DioException) {
        loggerPretty.e('Status Code: ${error.response?.statusCode}');
        loggerPretty.e('Response Data: ${error.response?.data}');
      }
      rethrow;
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      dynamic data = {
        'username': username,
        'password': password,
      };
      final response = await _apiService.post(
        endPoint: '/applogin',
        data: data,
      );
      loggerPrettyNoStack.i("This is token $response");
      if (response.data == 'DeviceNotFound') return response.data as String;
      // Assuming the API returns a token field
      final token = response.data['token'] as String;
      loggerPrettyNoStack.i("This is token $token");
      return token;
    } catch (error) {
      loggerPretty.e('Login failed: $error');
      rethrow;
    }
  }
}
