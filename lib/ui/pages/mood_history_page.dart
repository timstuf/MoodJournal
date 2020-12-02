import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/bloc/state.dart';
import 'package:mood_journal/bloc/user_mood_bloc.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/services/user_mood_group.dart';
import 'package:mood_journal/ui/pages/new_mood_page.dart';
import 'package:mood_journal/ui/views/day_widget.dart';
import 'package:mood_journal/ui/widgets/error.dart';

class MoodHistoryPage extends StatelessWidget {
  final int _userId;
  final _bloc = BlocProvider.getBloc<UserMoodPageBloc>();

  MoodHistoryPage({
    @required int userId,
    Key key,
  })  : _userId = userId,
        super(key: key) {
    _init();
  }

  void _init() {
    _bloc.getAllUserMoods(_userId);
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
                    onTap: () {},
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
              CupertinoPageRoute(
                  builder: (_) => NewMoodPage(

                  )),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: _buildPageContent(context),
          ),
        ));
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
    Map<DateTime, List<UserMoodModel>> groupedByDay =
        UserMoodGroup.groupByDay(userMoods);
    return SingleChildScrollView(
      child: Column(
          children: groupedByDay.entries
              .map((mood) => DayWidget(
                    dateTime: mood.key,
                    userMoods: mood.value,
                  ))
              .toList()),
    );
  }
}
