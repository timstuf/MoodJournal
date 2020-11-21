import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/mocks/mood_mock.dart';
import 'package:mood_journal/mocks/mood_number_mock.dart';
import 'package:mood_journal/models/mood_number.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/services/date_formatter.dart';
import 'package:mood_journal/ui/views/mood_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMoods = false;
  List<MoodNumber> moodNumbers = MoodNumberMock.moods;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.homePageTitle,
            style: GoogleFonts.raleway(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Column(children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 55),
                    child: Text(
                      "How would you rate this moment?",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: ButtonBar(mainAxisSize: MainAxisSize.min, children: [
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Text(
                          DateFormatter.dateFormatter(selectedDate),
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _selectTime(context),
                        child: Text(
                          DateFormatter.timeFormatter(selectedTime),
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: new ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: buildMoodNumbers(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buildMoods(),
                ),
              ])),
            ],
          ),
        ));
  }

  List<Widget> buildMoodNumbers() {
    List<Widget> listButtons = List.generate(moodNumbers.length, (i) {
      MoodNumber mood = moodNumbers[i];
      return SizedBox(
        width: 40,
        child: MaterialButton(
          onPressed: () => {
            setState(() {
              showMoods = true;
              mood.pressButton(moodNumbers);
            })
          },
          color: mood.color,
          child: Text(
            mood.name,
            style: new TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          padding: EdgeInsets.all(5),
          shape: mood.isPressed
              ? RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(100))
              : CircleBorder(),
        ),
      );
    });
    return listButtons;
  }

  List<Widget> buildMoods() {
    return showMoods
        ? MoodMock.moods
            .map((mood) => MoodTile(
                  mood: mood,
                  moodNumbers: moodNumbers,
                ))
            .toList()
        : new List<Widget>();
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime, // Refer step 1
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
}
