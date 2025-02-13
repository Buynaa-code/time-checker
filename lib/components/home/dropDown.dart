import 'package:flutter/material.dart';
import 'package:time_checker/const/colors.dart';
import 'package:time_checker/const/text_field.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: informationColor6,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedDate,
        hint: Text(
          "Он сар сонгох",
          style: ktsBodyLargeBold.copyWith(color: whiteColor),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        iconEnabledColor: whiteColor,
        items: ["2025-01", "2025-02", "2025-03"]
            .map((date) => DropdownMenuItem(
                  value: date,
                  child: Text(date,
                      style: ktsBodyLargeBold.copyWith(color: whiteColor)),
                ))
            .toList(),
        onChanged: (newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
      ),
    );
  }
}
