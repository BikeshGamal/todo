import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:login/cubit/add_todo_cubit.dart';
import 'package:login/cubit/delete_todo_cubit.dart';
import 'package:login/cubit/fetch_todo_cubit.dart';
import 'package:login/cubit/todo_event.dart';
import 'package:login/cubit/update_todo_cubit.dart';
import 'package:login/repository/local_note_repository.dart';
import 'package:login/repository/remote_note_repository.dart';
import 'package:login/to_do/todo_listing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => RemoteNoteRepository(),
          ),
          RepositoryProvider(
            create: (context) => LocalNoteRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => DeleteTodoCubit(
                    repository: context.read<LocalNoteRepository>())),
            BlocProvider(
                create: (context) => AddTodoCubit(
                    repository: context.read<LocalNoteRepository>())),
            BlocProvider(
                create: (context) => UpdateTodoCubit(
                    repository: context.read<LocalNoteRepository>())),
            BlocProvider(
              create: (context) => FetchTodoCubit(
                  repo: context.read<LocalNoteRepository>(),
                  deleteTodoCubit: context.read<DeleteTodoCubit>(),
                  addTodoCubit: context.read<AddTodoCubit>(),
                  updateTodoCubit: context.read<UpdateTodoCubit>())
                ..add(FetchTodoEvent()),
            ),
          ],
          child: MaterialApp(
            home: TodoListingScreen(),
          ),
        ),
      ),
    );
  }
}
