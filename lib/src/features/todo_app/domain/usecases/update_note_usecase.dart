import '../entities/note_entity.dart';
import '../repositories/firebase_repository.dart';

class UpdateNoteUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateNoteUsecase({required this.firebaseRepository});

  Future<void> call(NoteEntity note) async {
    return firebaseRepository.updateNote(note);
  }
}
