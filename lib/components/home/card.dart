import 'package:flutter/material.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/text_field.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String? selectedDate;
  List<Map<String, dynamic>> cards = [
    {
      'name': 'Ажилтан 1',
      'section': 'Хэсэг A',
      'district': 'Дүүрэг 1',
      'isToggled': false
    },
    {
      'name': 'Ажилтан 2',
      'section': 'Хэсэг B',
      'district': 'Дүүрэг 2',
      'isToggled': false
    },
    {
      'name': 'Ажилтан 3',
      'section': 'Хэсэг C',
      'district': 'Дүүрэг 3',
      'isToggled': false
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchDateFromService();
  }

  Future<void> fetchDateFromService() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      selectedDate = "2025-02";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          var card = cards[index];
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
                title: Text(card['name'],
                    style: ktsBodyLargeBold.copyWith(color: greyColor8)),
                subtitle: Text(
                  "${card['section']} - ${card['district']}",
                  style: ktsBodyRegular.copyWith(color: greyColor5),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chip(
                      label: Text(
                        card['isToggled'] ? "Ирсэн" : "Ирээгүй",
                        style: ktsBodyRegular.copyWith(color: whiteColor),
                      ),
                      backgroundColor:
                          card['isToggled'] ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: card['isToggled'],
                      onChanged: (value) {
                        setState(() {
                          cards[index]['isToggled'] = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
