import 'package:fluttererrorreport/model/data.dart';

abstract class DatabaseState {}

class LoadingState extends DatabaseState {}

class DataLoadedState extends DatabaseState {
  final List<Data> rows;

  DataLoadedState(this.rows);
}
