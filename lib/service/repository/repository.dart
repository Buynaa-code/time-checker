import 'package:time_checker/service/model/member_model.dart';

abstract class Repository {
  Future<List<Member>> getMemberService();
  Future<String> login(String username, String password);
}
