import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp_clean_project/src/features/todo_app/data/remote/datasources/firebase_remote_datasource.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/user_entity.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/note_entity.dart';

import '../models/note_model.dart';
import '../models/user_model.dart';

class FirebaseRemoteDatasourceImplementation
    implements FirebaseRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseRemoteDatasourceImplementation({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<void> addNewNote(NoteEntity noteEntity) async {
    final noteCollection = firebaseFirestore
        .collection("users")
        .doc(noteEntity.uid)
        .collection("notes");
    final noteId = noteCollection.doc().id;
    noteCollection.doc(noteId).get().then((note) {
      final newNote = NoteModel(
        uid: noteEntity.uid,
        noteId: noteEntity.noteId,
        note: noteEntity.note,
        time: noteEntity.time,
      ).toDocument();

      if (!note.exists) {
        noteCollection.doc(noteId).set(newNote);
      }
      return;
    });
  }

  @override
  Future<void> deleteNote(NoteEntity noteEntity) async {
    final noteCollection = firebaseFirestore
        .collection("users")
        .doc(noteEntity.uid)
        .collection("notes");

    noteCollection.doc(noteEntity.noteId).get().then((note) {
      if (note.exists) {
        noteCollection.doc(noteEntity.noteId).delete();
      }
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firebaseFirestore.collection("users");
    final uid = await getCurrentUId();
    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        status: user.status,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    final noteCollectionRef =
        firebaseFirestore.collection("users").doc(uid).collection("notes");

    return noteCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => NoteModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => firebaseAuth
      .signInWithEmailAndPassword(email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => firebaseAuth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> updateNote(NoteEntity note) async {
    Map<String, dynamic> noteMap = Map();
    final noteCollectionRef =
        firebaseFirestore.collection("users").doc(note.uid).collection("notes");

    if (note.note != null) noteMap['note'] = note.note;
    if (note.time != null) noteMap['time'] = note.time;

    noteCollectionRef.doc(note.noteId).update(noteMap);
  }
}
