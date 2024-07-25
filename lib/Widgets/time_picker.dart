import 'dart:developer';

import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  late TimeOfDay? selectedtime;
  final Function(String) onTimeSelected;

  TimePicker({super.key, this.selectedtime, required this.onTimeSelected});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.selectedtime != null) {
      selectedTime = _formatTime(widget.selectedtime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: const Size(150, 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(color: Colors.black),
      ),
      onPressed: () async {
        var time = await showTimePicker(
          context: context,
          initialTime: widget.selectedtime ?? TimeOfDay.now(),
        );
        if (time != null) {
          setState(() {
            selectedTime = _formatTime(time);
          });
          widget.onTimeSelected(selectedTime!);
        }
        
      },
      child: const Text(
        "Pick your time",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  TimeOfDay? getTime() {
    if (selectedTime != null) {
      final parts = selectedTime!.split(' ');
      final timeParts = parts[0].split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final period = parts[1];
      return TimeOfDay(
        hour: period == 'AM' ? hour % 12 : (hour % 12) + 12,
        minute: minute,
      );
    }
    return null;
  }
}
