import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/bloc/mood_bloc.dart';
import 'package:mood_journal/bloc/state.dart';
import 'package:mood_journal/models/mood_number.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/resources/utils.dart';
import 'package:mood_journal/services/date_formatter.dart';
import 'package:mood_journal/ui/views/itemview/my_text.dart';
import 'package:mood_journal/ui/views/mood_tile.dart';
import 'package:mood_journal/ui/widgets/error.dart';

class NewMoodPage extends StatefulWidget {
  final int _userId;

  const NewMoodPage(this._userId);

  @override
  _NewMoodPageState createState() => _NewMoodPageState(_userId);
}

class _NewMoodPageState extends State<NewMoodPage> {
  final int _userId;
  final _bloc = BlocProvider.getBloc<MoodPageBloc>();
  bool showMoods = false;
  List<MoodNumber> moodNumbers = MoodNumber.getAllMoods();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  _NewMoodPageState(this._userId);

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
          title: MyText(
            text: Strings.homePageTitle,
            weight: FontWeight.w600,
            size: 20,
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
                    child: MyText(
                        text: Strings.howWouldYouRateThisMoment, size: 30),
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
    return Container(
        child: GridView.count(
            shrinkWrap: true,
            primary: false,
            childAspectRatio: 50 / 15,
            padding: const EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: showMoods
                ? moods
                    .map((mood) => MoodTile(
                          mood: mood,
                          moodNumbers: moodNumbers,
                          date: DateFormatter.date(selectedDate, selectedTime),
                          userId: _userId,
                        ))
                    .toList()
                : new List<Widget>()));
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
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Utils.getMainColor()),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Utils.getMainColor()),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
}
