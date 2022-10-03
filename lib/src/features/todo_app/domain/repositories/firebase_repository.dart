import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/note_entity.dart';

import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<void> addNewNote(NoteEntity user);
  Future<void> updateNote(NoteEntity user);
  Future<void> deleteNote(NoteEntity user);
  Stream<List<NoteEntity>> getNotes(String uid);
}
