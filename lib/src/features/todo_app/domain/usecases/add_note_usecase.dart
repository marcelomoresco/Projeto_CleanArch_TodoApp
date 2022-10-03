import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/note_entity.dart';

import '../repositories/firebase_repository.dart';

class AddNoteUsecase {
  final FirebaseRepository firebaseRepository;

  AddNoteUsecase({required this.firebaseRepository});

  Future<void> call(NoteEntity note) async {
    return firebaseRepository.addNewNote(note);
  }
}
