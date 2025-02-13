import 'package:flutter/material.dart';

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
        color: Colors.white,
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
        hint: const Text(
          "Он сар сонгох",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        iconEnabledColor: Colors.blueAccent,
        items: ["2025-01", "2025-02", "2025-03"]
            .map((date) => DropdownMenuItem(
                  value: date,
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
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
