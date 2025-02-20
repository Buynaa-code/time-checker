import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_checker/bloc/auth_bloc.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/text_field.dart';
import 'package:time_checker/service/app/di.dart';
import 'package:time_checker/service/model/member_model.dart';
import 'package:time_checker/service/model/arrive_check.dart';
import 'package:logger/logger.dart';

import 'package:time_checker/service/repository/repository.dart';

final Logger loggerPretty = Logger();

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Repository _repository = instance<Repository>();
  Map<int, bool> memberStatus = {};

  Future<void> _irsenIreegui(Member member) async {
    final String irsenIreegui = memberStatus[member.id] == true ? '0' : '1';
    final ArriveCheck arriveCheck = ArriveCheck(
      value: irsenIreegui,
      itgegchId: member.id,
      ognoo: DateFormat('yyyy-MM-dd')
          .format(DateTime.now()), // Assume today’s date
    );

    // Print the member details being processed
    print(
        'Sending request for member: ${member.ner}, ID: ${member.id}, Status: $irsenIreegui');

    try {
      await _repository.sendArrival(arriveCheck);
      // ignore: use_build_context_synchronously
      _showSnackBar(context, 'Амжилттай илгээлээ.', true);
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, 'Явцад алдаа гарлаа.', false);
    }
  }

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? successColor4 : dangerColor5,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is MeInfoLoaded) {
          List<Member> members = state.memberList;

          if (members.isEmpty) {
            return const Center(
              child: Text(
                "Хоосон байна",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                var member = members[index];
                bool isArrived = member.irts == 1;

                return Card(
                  color: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.blueAccent,
                        backgroundImage: (member.zurag != null &&
                                member.zurag!.isNotEmpty &&
                                Uri.parse(
                                        "https://office.jbch.mkh.mn/storage/${member.zurag}")
                                    .isAbsolute)
                            ? NetworkImage(
                                "https://office.jbch.mkh.mn/storage/${member.zurag}")
                            : null,
                        child: (member.zurag == null ||
                                member.zurag!.isEmpty ||
                                !Uri.parse(
                                        "https://office.jbch.mkh.mn/storage/${member.zurag}")
                                    .isAbsolute)
                            ? const Icon(Icons.person,
                                color: whiteColor, size: 48)
                            : null,
                      ),
                      title: Text(member.ner,
                          style: ktsBodyLargeBold.copyWith(color: greyColor8)),
                      subtitle: (member.utas != null && member.utas!.isNotEmpty)
                          ? Text(member.utas!,
                              style: ktsBodyRegular.copyWith(color: greyColor5))
                          : Text("Утасны дугаар байхгүй",
                              style:
                                  ktsBodyRegular.copyWith(color: greyColor5)),
                      trailing: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Determine the current arrival status
                            Text(
                              (memberStatus[member.id] ?? isArrived)
                                  ? 'Ирсэн'
                                  : 'Ирээгүй',
                              style: ktsBodySmallBold.copyWith(
                                color: (memberStatus[member.id] ?? isArrived)
                                    ? successColor4
                                    : dangerColor5,
                              ),
                            ),
                            Switch(
                              value: memberStatus[member.id] ?? isArrived,
                              onChanged: (value) {
                                setState(() {
                                  memberStatus[member.id] =
                                      value; // Update the status in memberStatus
                                });
                                _irsenIreegui(
                                    member); // Send the request to update the status
                              },
                              activeColor: successColor4,
                              inactiveThumbColor: dangerColor5,
                              inactiveTrackColor: dangerColor5.withOpacity(0.3),
                              activeTrackColor: successColor4.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
