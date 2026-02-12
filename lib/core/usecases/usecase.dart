import 'package:dartz/dartz.dart';
import 'package:pdi_dost/core/error/failures.dart';

// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
