// coverage:ignore-file

import 'package:equatable/equatable.dart';

/// A base Failure class.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// A class that will be returned when a **Server Failure** occurs.
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// A class that will be returned when a **Connection Failure** occurs.
class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

/// A class that will be returned when a **Database Failure** occurs.
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}
