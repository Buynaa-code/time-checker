import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_checker/bloc/auth_bloc.dart';
import 'package:time_checker/components/home/button.dart';
import 'package:time_checker/components/home/card.dart';
import 'package:time_checker/components/home/dropDown.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/spacing.dart';
import 'package:time_checker/const/text_field.dart';
import 'package:time_checker/screens/login/login_screen.dart';
import 'package:time_checker/service/model/member_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Member? members;
  String? selectedDate;

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

  // Carousel images list

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is MeInfoLoaded && members != null) {
        return Scaffold(
          backgroundColor: greyColor2,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20,
            ),
            child: Column(
              children: [
                h48(),
                // Dropdown он сарын сонгох
                const DropdownWidget(),
                h12(),
                // Итгэгчдийн мэдээллийн жагсаалт
                const Cart(),
                // Хадгалах товч
                const SaveButton(),
              ],
            ),
          ),
        );
      }
      return Container();
    });
  }
}
