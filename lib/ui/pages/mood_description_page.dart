import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/api/api_error.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/bloc/user_mood_bloc.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/views/itemview/my_text.dart';
import 'package:mood_journal/ui/widgets/error_dialog.dart';

import 'file:///C:/Users/agris/AndroidStudioProjects/mood_journal/lib/ui/views/itemview/mood_picture.dart';
import 'file:///C:/Users/agris/AndroidStudioProjects/mood_journal/lib/ui/views/itemview/text_area_view.dart';

import 'mood_history_page.dart';

class MoodDescriptionPage extends StatelessWidget {
  final MoodModel mood;
  final DateTime _dateTime;
  final int _userId;
  TextEditingController _descriptionController;

  MoodDescriptionPage(
      {Key key,
      @required this.mood,
      @required DateTime dateTime,
      @required int userId})
      : _userId = userId,
        _descriptionController = TextEditingController(),
        _dateTime = dateTime,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: MyText(
          text: Strings.todayMoodPageTitle,
          size: 20,
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
        _buildMoodPicture(),
        SizedBox(height: 3.0),
        _buildMoodName(),
        SizedBox(height: 30.0),
        _buildTextArea(context),
        SizedBox(height: 60.0),
        _buildNextButton(context)
      ],
    ));
  }

  Widget _buildMoodPicture() {
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

  Widget _buildMoodName() {
    return MyText(
      text: mood.name,
      size: 24,
    );
  }

  Widget _buildTextArea(BuildContext context) {
    return SizedBox(
        width: 300.0,
        child: TextAreaWidget(
          mood.moodNumber.color,
          _descriptionController,
        ));
  }

  Widget _buildNextButton(BuildContext context) {
    return MaterialButton(
        onPressed: () async {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => MoodHistoryPage(
                    userId: _userId,
                  )));
          UserMoodModel userMoodModel = new UserMoodModel(
              moodNumber: mood.moodNumber,
              userId: _userId,
              moodModel: mood,
              dateTime: _dateTime,
              description: _descriptionController.text);
          try {
            await BlocProvider.getBloc<UserMoodPageBloc>()
                .apiClient
                .saveUserMood(userMoodModel);
          } on ApiError catch (ex) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(message: ex.message.toString())
                      .build(context);
                });
          }
        },
        color: mood.moodNumber.color,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: MyText(
            text: "Next",
            size: 20,
            color: Colors.white,
          ),
        ));
  }
}
