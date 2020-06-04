import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttererrorreport/bloc/database/event.dart';
import 'package:fluttererrorreport/bloc/database/state.dart';
import 'package:fluttererrorreport/model/data.dart';

import 'bloc/database/bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext _) => DatabaseBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseBloc databaseBloc;

  @override
  void initState() {
    super.initState();
    databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc.add(GetAllEvent());
  }

  @override
  void dispose() {
    databaseBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error report"),
      ),
      body: BlocBuilder(
        builder: (BuildContext context, state) {
          if (state is DataLoadedState) {
            List<Data> rows = state.rows;
            return Center();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              databaseBloc.add(AddSuccessEvent());
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              databaseBloc.add(AddPendingEvent());
            },
            child: Icon(Icons.timelapse),
          ),
          FloatingActionButton(
            onPressed: () {
              databaseBloc.add(AddErrorEvent());
            },
            child: Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}
