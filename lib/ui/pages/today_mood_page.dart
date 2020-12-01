import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/api/api_error.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/bloc/user_mood_bloc.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/views/text_area_view.dart';
import 'package:mood_journal/ui/views/mood_picture.dart';
import 'package:mood_journal/ui/widgets/error_dialog.dart';

import 'mood_history_page.dart';

class TodayMoodPage extends StatelessWidget {
  final MoodModel mood;
  final DateTime dateTime;

  const TodayMoodPage({
    Key key,
    @required this.mood,
    @required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: Text(
          Strings.todayMoodPageTitle,
          style: GoogleFonts.raleway(color: Colors.black),
        ),
        backgroundColor: mood.moodNumber.color,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: _buildPageContent(context),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.0),
            _buildContactPicture(),
            SizedBox(height: 3.0),
            _buildFullName(),
            SizedBox(height: 30.0),
            _buildTextArea(context),
            SizedBox(height: 60.0),
            _buildNextButton(context)
          ],
        ));
  }

  Widget _buildContactPicture() {
    return Center(
      child: Hero(
        tag: mood.uniqueTag,
        child: MoodPicture(
          assetPath: mood.assetPath,
          size: 50.0,
        ),
      ),
    );
  }

  Widget _buildFullName() {
    return Text(
      mood.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    );
  }

  Widget _buildTextArea(BuildContext context) {
    return SizedBox(
        width: 300.0, child: TextAreaWidget(moodColor: mood.moodNumber.color));
  }

  Widget _buildNextButton(BuildContext context) {
    return MaterialButton(
        onPressed: ()async{Navigator.of(context)
            .push(CupertinoPageRoute(builder: (_) => MoodHistoryPage(userId: 1,)));
        UserMoodModel userMoodModel = new UserMoodModel(moodNumber: mood.moodNumber, userId: 1, moodModel: mood, dateTime: dateTime, description: "");
        try {
          await BlocProvider.getBloc<UserMoodPageBloc>()
              .apiClient
              .saveUserMood(userMoodModel);
        } on ApiError catch (ex)
        {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                    message: "Error. status code: " +
                        ex.statusCode.toString())
                    .build(context);
              });
        }
      },
      color: mood.moodNumber.color,
      child: Text(
        "Next",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      padding: EdgeInsets.all(5),
    );
  }
}
