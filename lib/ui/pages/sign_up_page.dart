import 'package:flutter/material.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/resources/utils.dart';
import 'package:mood_journal/ui/pages/sign_in_page.dart';
import 'package:mood_journal/ui/views/itemview/entry_field.dart';
import 'package:mood_journal/ui/views/itemview/mood_journal_title.dart';
import 'package:mood_journal/ui/views/itemview/my_text.dart';
import 'package:mood_journal/ui/views/itemview/sign_in_up_button.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyText(text: Strings.alreadyAccount, size: 13),
            SizedBox(
              width: 10,
            ),
            MyText(
                text: Strings.signIn,
                color: Utils.getDarkerMainColor(),
                size: 13),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        EntryField(
          title: Strings.userName,
          isPassword: false,
        ),
        EntryField(title: Strings.password, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: MyText(
            text: Strings.signUp,
            size: 22,
          ),
          centerTitle: true),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    MoodJournalTitle(size: 40),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    SignInUpButton(text: Strings.signUp),
                    SizedBox(height: 30),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
