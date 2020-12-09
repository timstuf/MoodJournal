import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/bloc/state.dart';
import 'package:mood_journal/bloc/user_mood_bloc.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/services/date_formatter.dart';
import 'package:mood_journal/services/user_mood_group.dart';
import 'package:mood_journal/ui/pages/new_mood_page.dart';
import 'package:mood_journal/ui/views/day_widget.dart';
import 'package:mood_journal/ui/views/itemview/my_text.dart';
import 'package:mood_journal/ui/widgets/error.dart';

class MoodHistoryPage extends StatefulWidget {
  final int _userId;
  final _bloc = BlocProvider.getBloc<UserMoodPageBloc>();

  MoodHistoryPage({
    @required int userId,
    Key key,
  })  : _userId = userId,
        super(key: key);

  @override
  createState() => _MoodHistoryPageState(_userId, _bloc);
}

class _MoodHistoryPageState extends State<MoodHistoryPage> {
  final int _userId;
  final _bloc;
  DateTime selectedDate;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  _MoodHistoryPageState(this._userId, this._bloc);

  @override
  void initState() {
    _bloc.getAllUserMoods(_userId);
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
          leading: new Container(),
          title: Text(
            Strings.moodHistoryPageTitle,
            style: GoogleFonts.raleway(color: Colors.black),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Icon(
                    Icons.calendar_today,
                    size: 26.0,
                  ),
                )),
          ]),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => NewMoodPage(_userId)),
          );
        },
      ),
      body: _buildPageContent(context),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return StreamBuilder<AppState<List<UserMoodModel>>>(
      stream: _bloc.stream,
      builder: _buildResponse,
    );
  }

  Widget _buildResponse(
    BuildContext context,
    AsyncSnapshot<AppState<List<UserMoodModel>>> snapshot,
  ) {
    //no data
    if (!snapshot.hasData) {
      return SizedBox(
          height: 60.0,
          child: Center(
            child: Text(Strings.noData),
          ));
    }

    final moods = snapshot.data;
    if (moods is SuccessState) {
      return _buildDays((moods as SuccessState).data);
    } else {
      return new BlocError(currentState: moods);
    }
  }

  Widget _buildDays(List<UserMoodModel> userMoods) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _getData,
        child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            children: _getItems(userMoods)));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  List<Widget> _getItems(List<UserMoodModel> userMoods) {
    Map<DateTime, List<UserMoodModel>> groupedByDay =
        UserMoodGroup.groupByDay(userMoods);
    if (selectedDate != null) {
      groupedByDay = UserMoodGroup.getMoodsOnDay(groupedByDay, selectedDate);
      if (groupedByDay[selectedDate] == null) {
        return [
          SizedBox(
            height: 30.0,
          ),
          Center(
              child: MyText(
                  text: "No moods on " +
                      DateFormatter.dateFormatter(selectedDate),
                  size: 20)),
          SizedBox(
            height: 200.0,
          ),
        ];
      }
    }
    return groupedByDay.entries
        .map((mood) => DayWidget(
              dateTime: mood.key,
              userMoods: mood.value,
            ))
        .toList();
  }

  Future<void> _getData() async {
    setState(() {
      _bloc.getAllUserMoods(_userId);
      selectedDate = null;
    });
  }
}
