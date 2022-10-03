import '../entities/note_entity.dart';
import '../repositories/firebase_repository.dart';

class DeleteNoteUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteNoteUsecase({required this.firebaseRepository});

  Future<void> call(NoteEntity note) async {
    return firebaseRepository.deleteNote(note);
  }
}
