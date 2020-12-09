import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/api/api_error.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/bloc/user_mood_bloc.dart';
import 'package:mood_journal/services/date_formatter.dart';
import 'package:mood_journal/ui/views/itemview/my_text.dart';
import 'package:mood_journal/ui/widgets/error_dialog.dart';

import 'file:///C:/Users/agris/AndroidStudioProjects/mood_journal/lib/ui/views/itemview/mood_picture.dart';
import 'file:///C:/Users/agris/AndroidStudioProjects/mood_journal/lib/ui/views/itemview/text_area_view.dart';

import 'mood_history_page.dart';

class ViewMoodDescriptionPage extends StatelessWidget {
  final UserMoodModel _mood;
  TextEditingController _descriptionController;

  ViewMoodDescriptionPage({Key key, @required UserMoodModel mood})
      : _mood = mood,
        _descriptionController = TextEditingController(),
        super(key: key) {
    _descriptionController.text = _mood.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: Text(
          "Mood on " +
              DateFormatter.dateFormatter(_mood.dateTime) +
              " " +
              DateFormatter.getTime(_mood.dateTime),
          style: GoogleFonts.raleway(color: Colors.black),
        ),
        backgroundColor: _mood.moodNumber.color,
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
        tag: _mood.moodModel.uniqueTag,
        child: MoodPicture(
          assetPath: _mood.moodModel.assetPath,
          size: 50.0,
        ),
      ),
    );
  }

  Widget _buildMoodName() {
    return MyText(
      text: _mood.moodModel.name,
      size: 24,
    );
  }

  Widget _buildTextArea(BuildContext context) {
    return SizedBox(
        width: 300.0,
        child: TextAreaWidget(
          _mood.moodNumber.color,
          _descriptionController,
        ));
  }

  Widget _buildNextButton(BuildContext context) {
    return MaterialButton(
        onPressed: () async {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => MoodHistoryPage(
                    userId: _mood.userId,
                  )));
          _mood.description = _descriptionController.text;
          try {
            await BlocProvider.getBloc<UserMoodPageBloc>()
                .apiClient
                .editUserMood(_mood);
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
        color: _mood.moodNumber.color,
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
