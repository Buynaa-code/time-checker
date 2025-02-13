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

                return Card(
                  color: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40, // Icon болон зурагны хэмжээ томсгох
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
                                color: whiteColor,
                                size: 48) // Icon-ийн хэмжээ томсгосон
                            : null,
                      ),
                      title: Text(member.ner,
                          style: ktsBodyLargeBold.copyWith(color: greyColor8)),
                      subtitle: (member.utas.isNotEmpty)
                          ? Text(
                              member.utas,
                              style: ktsBodyRegular.copyWith(color: greyColor5),
                            )
                          : Text(
                              "Утасны дугаар бүртгэгдээгүй байна",
                              style: ktsBodyRegular.copyWith(color: greyColor5),
                            ),
                    ),
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
