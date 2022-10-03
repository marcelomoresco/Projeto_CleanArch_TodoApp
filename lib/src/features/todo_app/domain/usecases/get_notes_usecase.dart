import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/note_entity.dart';

import '../repositories/firebase_repository.dart';

class GetNotesUsecase {
  final FirebaseRepository firebaseRepository;

  GetNotesUsecase({required this.firebaseRepository});

  Stream<List<NoteEntity>> call(String uid) {
    return firebaseRepository.getNotes(uid);
  }
}
