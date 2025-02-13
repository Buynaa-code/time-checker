import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_checker/bloc/auth_bloc.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/text_field.dart';
import 'package:time_checker/service/model/member_model.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<int, bool> memberStatus =
      {}; // Track the status of each member (arrived or not)

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

                bool isArrived = memberStatus[index] ?? false;

                return Card(
                  color: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blueAccent,
                          backgroundImage: (member.zurag != null &&
                                  member.zurag!.isNotEmpty &&
                                  Uri.parse(
                                          "https://office.jbch.mkh.mn/storage/${member.zurag}")
                                      .isAbsolute)
                              ? NetworkImage(
                                      "https://office.jbch.mkh.mn/storage/${member.zurag}")
                                  as ImageProvider
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
                            style:
                                ktsBodyLargeBold.copyWith(color: greyColor8)),
                        subtitle: (member.utas.isNotEmpty)
                            ? Text(
                                member.utas,
                                style:
                                    ktsBodyRegular.copyWith(color: greyColor5),
                              )
                            : Text(
                                "Утасны дугаар байхгүй",
                                style:
                                    ktsBodyRegular.copyWith(color: greyColor5),
                              ),
                        trailing: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Minimize the space taken by the column
                          children: [
                            Expanded(
                              child: Text(
                                isArrived ? 'Ирсэн' : 'Ирээгүй',
                                style: ktsBodySmallBold.copyWith(
                                  color:
                                      isArrived ? successColor4 : dangerColor5,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height:
                                    4), // Add a smaller height for reduced space between the text and switch
                            Expanded(
                              child: Switch(
                                value: isArrived,
                                onChanged: (value) {
                                  setState(() {
                                    memberStatus[index] = value;
                                  });
                                },
                                activeColor: successColor4,
                                inactiveThumbColor: dangerColor5,
                                inactiveTrackColor:
                                    dangerColor5.withOpacity(0.3),
                                activeTrackColor:
                                    successColor4.withOpacity(0.3),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
