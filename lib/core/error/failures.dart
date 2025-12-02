import 'package:equatable/equatable.dart';

/// Failure Class: It is an abstract class that handles failures or
/// exceptions which can be of any dynamic types
/// Equatable helps to equate any objects for easy comparision
abstract class Failure extends Equatable {
  final String message;
  const Failure({this.message = 'Something went wrong'});
}

/// General Failures
class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server Failure'}) : super(message: message);
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache Failure'}) : super(message: message);
  @override
  List<Object> get props => [message];
}
