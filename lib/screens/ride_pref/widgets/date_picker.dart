import 'package:flutter/material.dart';

class CustomDatePickerScreen extends StatefulWidget {
  final DateTime? initialDate;

  const CustomDatePickerScreen({this.initialDate, super.key});

  @override
  _CustomDatePickerScreenState createState() => _CustomDatePickerScreenState();
}

class _CustomDatePickerScreenState extends State<CustomDatePickerScreen> {
  late DateTime _selectedDate;
  final DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? _currentDate;
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.of(context)
          .pop(_selectedDate); // Return the selected date after a delay
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Select Date'),
      ),
      body: ListView(
        children: List.generate(12, (index) {
          return _buildMonthCalendar(DateTime(_selectedDate.year, index + 1));
        }),
      ),
    );
  }

  Widget _buildMonthCalendar(DateTime month) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${_getMonthName(month.month)} ${month.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemCount:
              _getDaysInMonth(month) + _getFirstWeekdayOfMonth(month) - 1,
          itemBuilder: (context, index) {
            if (index < _getFirstWeekdayOfMonth(month) - 1) {
              return Container(); // Empty space for days before the first of the month
            }
            final day = index - _getFirstWeekdayOfMonth(month) + 2;
            final date = DateTime(month.year, month.month, day);
            bool isToday = date.year == _currentDate.year &&
                date.month == _currentDate.month &&
                date.day == _currentDate.day;
            return GestureDetector(
              onTap: () => _onDateSelected(date),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: date == _selectedDate ? Colors.blue : null,
                  shape: BoxShape.circle,
                  border: isToday ? Border.all(color: Colors.grey) : null,
                ),
                child: Text(
                  '$day',
                  style: TextStyle(
                    color: date == _selectedDate ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _getFirstWeekdayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
