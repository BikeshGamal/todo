import 'package:dartz/dartz.dart';
import 'package:login/database/database_services.dart';
import 'package:login/repository/inote_repository.dart';
import 'package:login/to_do/todo.dart';

class LocalNoteRepository implements INoteRepository {
  final databaseServices = DatabaseServices();
  @override
  Future<Either<String, List<Todo>>> addTodo(
      {required String title, required String description}) async {
    await databaseServices.addNote(title: title, description: description);
    return Right([]);
  }

  @override
  Future<Either<String,List<Todo>>> deleteTodo({required String id}) async{
    await databaseServices.deleteNote(id: id);
    return Right([]);
  }

  @override
  Future<Either<String, List<Todo>>> fetchTodo() async{
  final res= await databaseServices.getNote();
  return Right(res);
  }

  @override
  Future<Either<String, List<Todo>>> updateTodo(
      {required String title,
      required String description,
      required String id}) async{
  await databaseServices.updateNote(id: id, title: title, description: description);
  return Right([]);
  }
}
