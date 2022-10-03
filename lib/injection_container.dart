import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp_clean_project/src/features/todo_app/data/remote/datasources/firebase_remote_datasource.dart';
import 'package:todoapp_clean_project/src/features/todo_app/data/remote/datasources/firebase_remote_datasource_implementation.dart';
import 'package:todoapp_clean_project/src/features/todo_app/data/repositories/firebase_repository_implementation.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/repositories/firebase_repository.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/add_note_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/delete_note_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/get_create_current_user_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/get_current_uid_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/get_notes_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/is_sign_in_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/sign_in_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/sign_out_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/sign_up_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/update_note_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/blocs/auth_cubit/auth_cubit.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/blocs/note_cubit/note_cubit.dart';
import 'package:todoapp_clean_project/src/features/todo_app/presentator/blocs/user_cubit/user_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //cubit

  sl.registerFactory(
    () => AuthCubit(
      getCurrentUIdUsecase: sl.call(),
      isSignInUsecase: sl.call(),
      signOutUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(
      signInUsecase: sl.call(),
      signUpUsecase: sl.call(),
      signOutUsecase: sl.call(),
      getCreateCurrentUserUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => NoteCubit(
      updateNoteUsecase: sl.call(),
      getNotesUsecase: sl.call(),
      addNoteUsecase: sl.call(),
      deleteNoteUsecase: sl.call(),
    ),
  );

  // usecase

  sl.registerLazySingleton<AddNoteUsecase>(
      () => AddNoteUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<DeleteNoteUsecase>(
      () => DeleteNoteUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIdUsecase>(
      () => GetCurrentUIdUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<GetNotesUsecase>(
      () => GetNotesUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<IsSignInUsecase>(
      () => IsSignInUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<UpdateNoteUsecase>(
      () => UpdateNoteUsecase(firebaseRepository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImplementation(remoteDatasource: sl.call()));

  //data source
  sl.registerLazySingleton<FirebaseRemoteDatasource>(
    () => FirebaseRemoteDatasourceImplementation(
      firebaseAuth: sl.call(),
      firebaseFirestore: sl.call(),
    ),
  );

  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firebaseFirestore);
}
