import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    final String? noteId,
    final String? note,
    final Timestamp? time,
    final String? uid,
  }) : super(
          noteId: noteId,
          note: note,
          time: time,
          uid: uid,
        );

  factory NoteModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return NoteModel(
      noteId: documentSnapshot.get('noteId'),
      note: documentSnapshot.get('note'),
      uid: documentSnapshot.get('uid'),
      time: documentSnapshot.get('time'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {"uid": uid, "time": time, "note": note, "noteId": noteId};
  }
}
