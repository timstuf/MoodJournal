import 'package:flutter/material.dart';

class TextAreaWidget extends StatefulWidget {
  final Color moodColor;

  TextAreaWidget({
    Key key,
    @required this.moodColor,
  }) : super(key: key);

  @override
  TextAreaWidgetState createState() => TextAreaWidgetState(moodColor);
}

class TextAreaWidgetState extends State {
  bool viewVisible = false;
  final Color moodColor;

  TextAreaWidgetState(this.moodColor);

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextArea(context);
  }

  Widget _buildTextArea(BuildContext context) {
    return SizedBox(
        width: 300.0,
        child: Column(
          children: [
            Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: !viewVisible,
                child: SizedBox(height: 60.0)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add some details...',
                fillColor: Colors.red,
              ),
              minLines: 3,
              maxLines: 3,
              onTap: showWidget,
              onEditingComplete: hideWidget,
            ),
            Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: viewVisible,
                child: _buildButtons(context))
          ],
        ));
  }

  Widget _buildButtons(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.0),
          IconButton(
            icon: Icon(
              Icons.check,
              size: 36.0,
              color: moodColor,
            ),
            onPressed: () {
              hideWidget();
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }
}
