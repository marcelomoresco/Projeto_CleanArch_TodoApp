// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoadingState extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoadedState extends NoteState {
  final List<NoteEntity> notes;

  const NoteLoadedState({
    required this.notes,
  });

  @override
  List<Object> get props => [notes];
}

class NoteErrorState extends NoteState {
  final String errorMessage;

  const NoteErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
