import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedexapp/core/error/failures.dart';

/// UseCase is an abstract class that will help us to extend a call function
/// which is used by all the use cases hence we do not need to make multiple naming
/// to each type of functions
/// Here, type: type of data to be return and params: things need for function
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Creating a no params class so that it will
/// create a class that has no parameters needed
class NoParams extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}