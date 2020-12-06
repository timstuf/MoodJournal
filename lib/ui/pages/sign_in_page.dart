import 'package:flutter/material.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/resources/utils.dart';
import 'package:mood_journal/ui/pages/sign_up_page.dart';
import 'package:mood_journal/ui/views/itemview/entry_field.dart';
import 'package:mood_journal/ui/views/itemview/mood_journal_title.dart';
import 'package:mood_journal/ui/views/itemview/my_text.dart';
import 'package:mood_journal/ui/views/itemview/sign_in_up_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyText(
              text: Strings.noAccount,
              size: 13,
            ),
            SizedBox(
              width: 10,
            ),
            MyText(
                text: Strings.signUp,
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
          controller: _userNameController,
        ),
        EntryField(
          title: Strings.password,
          isPassword: true,
          controller: _passwordController,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: MyText(
              text: Strings.signIn,
              size: 22,
            ),
            centerTitle: true),
        body: SingleChildScrollView(
          child: Column(
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
                      SizedBox(height: 50),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      SignInUpButton(
                        text: Strings.signIn,
                        isSignIn: true,
                        userNameController: _userNameController,
                        passwordController: _passwordController,
                      ),
                      SizedBox(height: 30),
                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
