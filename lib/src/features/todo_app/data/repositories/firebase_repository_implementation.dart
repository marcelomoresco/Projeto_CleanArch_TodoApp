import 'package:equatable/equatable.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/user_entity.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/note_entity.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/repositories/firebase_repository.dart';

import '../remote/datasources/firebase_remote_datasource.dart';

class FirebaseRepositoryImplementation implements FirebaseRepository {
  final FirebaseRemoteDatasource remoteDatasource;

  FirebaseRepositoryImplementation({required this.remoteDatasource});

  @override
  Future<void> addNewNote(NoteEntity note) async {
    return remoteDatasource.addNewNote(note);
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    return remoteDatasource.deleteNote(note);
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    return remoteDatasource.getCreateCurrentUser(user);
  }

  @override
  Future<String> getCurrentUId() async {
    return remoteDatasource.getCurrentUId();
  }

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    return remoteDatasource.getNotes(uid);
  }

  @override
  Future<bool> isSignIn() async {
    return remoteDatasource.isSignIn();
  }

  @override
  Future<void> signIn(UserEntity user) async {
    return remoteDatasource.signIn(user);
  }

  @override
  Future<void> signOut() async {
    return remoteDatasource.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    return remoteDatasource.signUp(user);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    return await remoteDatasource.updateNote(note);
  }
}
