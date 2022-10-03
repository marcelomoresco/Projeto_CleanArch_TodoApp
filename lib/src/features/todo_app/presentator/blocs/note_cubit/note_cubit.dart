import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/note_entity.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/add_note_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/delete_note_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/get_notes_usecase.dart';
import 'package:todoapp_clean_project/src/features/todo_app/domain/usecases/update_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUsecase updateNoteUsecase;
  final AddNoteUsecase addNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;
  final GetNotesUsecase getNotesUsecase;

  NoteCubit({
    required this.updateNoteUsecase,
    required this.getNotesUsecase,
    required this.addNoteUsecase,
    required this.deleteNoteUsecase,
  }) : super(NoteInitial());

  Future<void> addNote({required NoteEntity note}) async {
    try {
      await addNoteUsecase.call(note);
    } on SocketException catch (_) {
      emit(const NoteErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const NoteErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> deleteNote({required NoteEntity note}) async {
    try {
      await deleteNoteUsecase.call(note);
    } on SocketException catch (_) {
      emit(const NoteErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const NoteErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> updateNote({required NoteEntity note}) async {
    try {
      await updateNoteUsecase.call(note);
    } on SocketException catch (_) {
      emit(const NoteErrorState(errorMessage: "Acorreu um erro!"));
    } catch (_) {
      emit(const NoteErrorState(errorMessage: "Acorreu um erro!"));
    }
  }

  Future<void> getNotes({required String uid}) async {
    emit(NoteLoadingState());
    try {
      getNotesUsecase.call(uid).listen((notes) {
        emit(NoteLoadedState(notes: notes));
      });
    } on SocketException catch (_) {
      emit(const NoteErrorState(errorMessage: "Erro ao pegar notas!"));
    } catch (_) {
      emit(const NoteErrorState(errorMessage: "Acorreu um erro!"));
    }
  }
}
