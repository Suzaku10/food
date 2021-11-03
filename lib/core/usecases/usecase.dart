import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class IdMealParams extends Equatable {
  final String? id;

  const IdMealParams({this.id});

  @override
  List<Object?> get props => [id];
}
