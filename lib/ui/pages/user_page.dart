import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/api/model/user_model.dart';
import 'package:mood_journal/bloc/state.dart';
import 'package:mood_journal/bloc/user_block.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/widgets/itemview/UserView.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key key,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();

}
class _UserPageState extends State<UserPage> {
  final _bloc = BlocProvider.getBloc<UserPageBloc>();

  @override
  void initState() {
    _bloc.getAllUsers();
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
        title: Text(Strings.appName),
        centerTitle: true,
      ),
      body: StreamBuilder<AppState<List<UserModel>>>(
        stream: _bloc.userStream,
        builder: _buildResponse,
      ),
    );
  }

  Widget _buildResponse(
      BuildContext context,
      AsyncSnapshot<AppState<List<UserModel>>> snapshot,
      ) {
    //no data
    if (!snapshot.hasData) {
      return Center(
        child: Text("no data"),
      );
    }

    final tasks = snapshot.data;

    //initial state
    if (tasks is InitialState) {
      return Center(
        child: Text("initial state"),
      );
    }

    //loading tasks
    if (tasks is LoadingState) {
      return _buildLoader();
    }

    //loaded tasks
    if (tasks is SuccessState) {
      return _buildTasks((tasks as SuccessState).data);
    }

    //error
    if (tasks is ErrorState) {
      return _buildError((tasks as ErrorState).errorMessage);
    }

    return _buildLoader();
  }

  Widget _buildLoader() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildTasks(List<UserModel> tasks) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: tasks.length,
      itemBuilder: (_, index) => UserView(
        task: tasks[index],
        onChanged: () {},
      ),
    );
  }

  void _addTask() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text("add user "),
              ));
        });
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Text(
          errorMessage,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
