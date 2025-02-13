import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:time_checker/components/home/button.dart';
import 'package:time_checker/components/home/card.dart';
import 'package:time_checker/components/home/dropDown.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/spacing.dart';
import 'package:time_checker/const/text_field.dart';
import 'package:time_checker/screens/login/login_screen.dart';
import 'package:time_checker/service/app/di.dart';
import 'package:time_checker/service/model/member_model.dart';
import 'package:time_checker/service/repository/repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Repository _repository = instance<Repository>();
  List<Member> members = [];
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

  Future<void> initMemberkValue() async {
    try {
      final value = await _repository.getMemberService();
      setState(() {
        members = value;
      });
    } catch (e) {
      if (e.toString().contains("Salary period not found")) {
        // Сайжруулсан диалог харуулна
        showDialog(
          context: context,
          barrierDismissible: false, // Хоосон хэсэг дээр дарахад хаагдахгүй
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Булангийн радиус
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Миний хэмжээ барина
                  children: [
                    Icon(
                      Icons.warning_amber_rounded, // Анхааруулгын дүрс
                      size: 50,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Анхааруулга',
                      style: ktsBodyLargeBold.copyWith(color: greyColor8),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Цалингийн үечлэл олдсонгүй.',
                      textAlign: TextAlign.center,
                      style: ktsBodyMedium.copyWith(
                        color: greyColor6,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Диалогоос гарах
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Товчлуурын өнгө
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Ойлголоо',
                          style: ktsBodyMedium.copyWith(color: whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Алдаа гарлаа: $e'),
            backgroundColor: Colors.red, // Алдааны өнгө
          ),
        );
      }
    }
  }

  // Carousel images list

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  var member = members[index];
                  return Card(
                    color: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(
                            Icons.person,
                            color: whiteColor,
                            size: 34,
                          ),
                        ),
                        title: Text(member.ner,
                            style:
                                ktsBodyLargeBold.copyWith(color: greyColor8)),
                        subtitle: Text(
                          "${member.khesegBagId} - ${member.zurag}",
                          style: ktsBodyRegular.copyWith(color: greyColor5),
                        ),
                        // trailing: Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     Chip(
                        //       label: Text(
                        //        members[index].gerelsenu ? "Ирсэн" : "Ирээгүй",
                        //         style:
                        //             ktsBodyRegular.copyWith(color: whiteColor),
                        //       ),
                        //       backgroundColor:
                        //           card['isToggled'] ? Colors.green : Colors.red,
                        //     ),
                        //     const SizedBox(width: 8),
                        //     Switch(
                        //       value: card['isToggled'],
                        //       onChanged: (value) {
                        //         setState(() {
                        //           members[index]['isToggled'] = value;
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Итгэгчдийн мэдээллийн жагсаалт
            const Cart(),
            // Хадгалах товч
            const SaveButton(),
          ],
        ),
      ),
    );
  }
}
