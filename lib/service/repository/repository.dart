import 'package:time_checker/service/model/arrive_check.dart';
import 'package:time_checker/service/model/date_info.dart';
import 'package:time_checker/service/model/member_model.dart';

abstract class Repository {
  Future<List<Member>> getMemberService();
  Future<String> login(String username, String password);
  Future<List<DateInfo>> fetchDateInfo();
  Future<void> sendArrival(ArriveCheck irsernIreegui);
}
