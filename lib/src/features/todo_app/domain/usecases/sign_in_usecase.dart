import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/user_entity.dart';

import '../repositories/firebase_repository.dart';

class SignInUsecase {
  final FirebaseRepository firebaseRepository;

  SignInUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return firebaseRepository.signIn(user);
  }
}
