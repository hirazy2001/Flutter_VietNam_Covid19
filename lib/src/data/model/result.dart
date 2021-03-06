import 'package:flutter_vietnam_covid19/src/data/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T>{

  const Result._();

  factory Result.success({required T data}) = Success<T>;

  factory Result.failure({required AppError error}) = Failure<T>;

  static Result<T> guard <T>(T Function() body){
    try{
      return Result.success(data: body());
    }
    on Exception catch(e){
      return Result.failure(error: AppError(e));
    }
  }

  static Future<Result<T>> guardFuture<T>(Future<T> Function() future ) async{
    try{
      return Result.success(data: await future());
    }
    on Exception catch(e){
      return Result.failure(error: AppError(e));
    }
  }

  bool get isSuccess => when(success: (data) => true, failure: (e) => false);

  bool get isFailure => !isSuccess;

  void ifFailure(Function(AppError e) body){
    maybeWhen(
      failure: (e) => body(e),
      orElse: () {

      }
    );
  }

  T get dataOrThrow{
    return when(
      success: (data) => data,
      failure: (e) => throw e
    );
  }
}

extension ResultObjectExt<T> on T{

  Result<T> get asSuccess => Result.success(data: this);

  Result<T> asFailure(Exception e) => Result.failure(error: AppError(e));
}