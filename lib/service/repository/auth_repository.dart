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

      if (response.data == "Salary period not found") {
        throw Exception("Salary period not found");
      }

      if (response.data['data'] is List) {
        return (response.data['data'] as List)
            .map((e) => Member.fromJson(e))
            .toList();
      } else {
        throw Exception("Invalid data format");
      }
    } catch (error) {
      loggerPretty.d('Response data: $error');
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
