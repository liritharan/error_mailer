abstract class DatabaseEvent {}

class AddSuccessEvent extends DatabaseEvent {}

class AddPendingEvent extends DatabaseEvent {}

class AddErrorEvent extends DatabaseEvent {}

class GetAllEvent extends DatabaseEvent {}
