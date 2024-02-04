import 'package:dartz/dartz.dart';
import 'package:login/to_do/todo.dart';

abstract class INoteRepository {
  Future<Either<String, List<Todo>>> fetchTodo();
  Future<Either<String, List<Todo>>> addTodo(
      {required String title, required String description});
  Future<Either<String, List<Todo>>> updateTodo(
      {required String title, required String description, required String id});
  Future<Either<String, List<Todo>>> deleteTodo({required String id});
}
