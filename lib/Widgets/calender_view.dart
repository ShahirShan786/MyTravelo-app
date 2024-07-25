import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatefulWidget {
  final DateTime? rangestart;
  final DateTime? rangeend;
  bool? onGoing;
  CalenderView({this.rangestart, this.rangeend, this.onGoing, super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

DateTime dateTimeNow = DateTime.now();
DateTime? rangeStart;
DateTime? rangeEnd;

class _CalenderViewState extends State<CalenderView> {
  @override
  void initState() {
    super.initState();
    if (widget.rangestart != null && widget.rangeend != null) {
      rangeStart = widget.rangestart;
      rangeEnd = widget.rangeend;
    }
  }

  @override
  void dispose() {
    rangeStart = null;
    rangeEnd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onGoing != null && widget.onGoing == true) {
      rangeStart = widget.rangestart;
      rangeEnd = widget.rangeend;
    }
    return TableCalendar(
      focusedDay: dateTimeNow,
      rowHeight: 40.h,
      headerStyle:
          const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      rangeStartDay: rangeStart,
      rangeEndDay: rangeEnd,
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      firstDay: DateTime.utc(2010),
      lastDay: DateTime.utc(2025),
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, DateTime.now()),
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          rangeStart = start;
          rangeEnd = end;
          dateTimeNow = focusedDay;
          log("Starting Date :$rangeStart");
          log("Ending Date : $rangeEnd");
        });
      },
      onDaySelected: (selectedDay, focusedDay) {},
    );
  }
}

DateTime? getCalenderRangeStart() {
  return rangeStart;
}

DateTime? getCalenderRangeEnd() {
  return rangeEnd;
}
