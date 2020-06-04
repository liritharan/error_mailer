import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fluttererrorreport/bloc/database/event.dart';
import 'package:fluttererrorreport/bloc/database/state.dart';
import 'package:fluttererrorreport/model/data.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  List<Data> _rows;
  Database db;
  Dio dio;

  DatabaseBloc() {
    prepareDatabase();
    _rows = List<Data>();
    dio = Dio();
    dio.options.baseUrl = 'http://60.243.50.26';
    dio.options.contentType = 'application/json';
  }

  @override
  get initialState => LoadingState();

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    yield LoadingState();
    if (event is AddSuccessEvent) {
      Data row = Data('UpdateTask', 'Success');
      db.insert('reports', row.toMap());
    } else if (event is AddPendingEvent) {
      Data row = Data('UpdateStatus', 'Pending');
      db.insert('reports', row.toMap());
    } else if (event is AddErrorEvent) {
      Data row = Data('UpdatePerson', 'Error');
      db.insert('reports', row.toMap());
      await sendReport(row);
    }
    _rows = [];
    List<Map> rows = await db.query('reports');
    rows.forEach((element) {
      _rows.add(Data.fromMap(element));
    });
    yield DataLoadedState(_rows);
  }

  sendReport(Data data) async {
    print(data.toMap());
    await dio.get('/error-report', queryParameters: data.toMap());
  }

  void prepareDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = await join(databasesPath + 'demo.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE reports ('
          'id INTEGER PRIMARY KEY, '
          'transdesc TEXT, '
          'transstatus TEXT, '
          'transdatetime text)');
    });
  }
}
