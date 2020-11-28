import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/bloc/mood_bloc.dart';
import 'package:mood_journal/bloc/state.dart';
import 'package:mood_journal/models/mood_number.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/services/date_formatter.dart';
import 'package:mood_journal/ui/views/mood_tile.dart';
import 'package:mood_journal/ui/widgets/error.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = BlocProvider.getBloc<MoodPageBloc>();
  bool showMoods = false;
  List<MoodNumber> moodNumbers = MoodNumber.getAllMoods();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    _bloc.getAllMoods();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
                StreamBuilder<AppState<List<MoodModel>>>(
                  stream: _bloc.stream,
                  builder: _buildResponse,
                ),
              ])),
            ],
          ),
        ));
  }

  Widget _buildMoods(List<MoodModel> moods) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: showMoods
            ? moods
                .map((mood) => MoodTile(
                      mood: mood,
                      moodNumbers: moodNumbers,
                      date: DateFormatter.date(selectedDate, selectedTime),
                    ))
                .toList()
            : new List<Widget>());
  }

  Widget _buildResponse(
    BuildContext context,
    AsyncSnapshot<AppState<List<MoodModel>>> snapshot,
  ) {
    //no data
    if (!snapshot.hasData) {
      return Center(
        child: Text(Strings.noData),
      );
    }

    final moods = snapshot.data;
    if (moods is SuccessState) {
      return _buildMoods((moods as SuccessState).data);
    } else {
      return new BlocError(currentState: moods);
    }
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
            mood.number.toString(),
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
