import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_checker/components/home/card.dart';
import 'package:time_checker/components/home/dropDown.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/spacing.dart';
import 'package:time_checker/const/text_field.dart';
import 'package:time_checker/screens/login/login_screen.dart';
import 'package:time_checker/service/app/di.dart';
import 'package:time_checker/service/model/date_info.dart';

import 'package:time_checker/service/repository/repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedDate;
  final Repository _repository = instance<Repository>();
  List<DateInfo> dateInfo = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> logout() async {
    bool confirmLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: whiteColor,
        title: Text(
          "Гарах",
          style: ktsBodyMassiveBold.copyWith(color: greyColor8),
        ),
        content: Text("Та системээс гарахдаа итгэлтэй байна уу?",
            style: ktsBodyRegular.copyWith(color: greyColor5)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Үгүй",
                style: ktsBodyRegularBold.copyWith(color: greyColor8)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Тийм",
                style: ktsBodyRegularBold.copyWith(color: dangerColor5)),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor2,
      appBar: AppBar(
        surfaceTintColor: greyColor2,
        backgroundColor: greyColor2,
        title: Text(
          "Нүүр хуудас",
          style: ktsBodyMassiveBold.copyWith(color: greyColor8),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: dangerColor5),
            onPressed: logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            h12(),
            DropdownWidget(
                fetchDateInfo: _repository
                    .fetchDateInfo), // ✅ fetchDateInfo-г дамжуулж байна
            h24(),
            const Cart(),
          ],
        ),
      ),
    );
  }
}
