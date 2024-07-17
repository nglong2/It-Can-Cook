import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/part.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/template_day.dart';

class WeeklyDetailPage extends StatefulWidget {
  final List<RecipePlan> recipePlans;
  const WeeklyDetailPage({super.key, required this.recipePlans});

  @override
  WeeklyDetailPageState createState() => WeeklyDetailPageState();
}

class WeeklyDetailPageState extends State<WeeklyDetailPage> {
  //state //selected date
  int _selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${S.current.total}120000 vnđ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
                style: ButtonStyle(
                  //borderadius
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Color(0xFF02335A)))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF02335A)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 34,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_checkout_sharp,
                        color: Colors.white,
                      ),
                      Text(
                        S.of(context).add_to_cart,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  """ ${S.of(context).week} ${getCurrentWeekInMonth(DateTime.now().add(const Duration(days: 7)))}, ${DateFormat('MMMM').format(DateTime.now().add(const Duration(days: 7)))}, ${DateTime.now().add(Duration(days: DateTime.monday - DateTime.now().weekday + 7)).year}""",
                  // get moth name

                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 1.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DatePicker(
                  height: 100,
                  width: 75,
                  daysCount: 7,
                  locale: //get current locale
                      Localizations.localeOf(context).languageCode,
                  DateTime.now().add(Duration(
                      days: DateTime.monday - DateTime.now().weekday + 7)),
                  initialSelectedDate: DateTime.now().add(Duration(
                      days: DateTime.monday - DateTime.now().weekday + 7)),
                  selectionColor: const Color(0xFF02335A).withOpacity(0.8),
                  selectedTextColor: Colors.white,
                  dayTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                  monthTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                  dateTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                  onDateChange: (date) {
                    setState(() {
                      _selectedValue = date.weekday - 1;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 380,
            child: SingleChildScrollView(
              child: Part(
                dayInWeek: _selectedValue,
                recipes: widget.recipePlans
                    .where((element) => element.dayInWeek == _selectedValue)
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

int getCurrentWeekInMonth(DateTime time) {
  int firstDayOfMonth = DateTime(time.year, time.month, 1).weekday;
  int weekOfMonth = ((time.day + firstDayOfMonth - 1) / 7).ceil();
  return weekOfMonth;
}
