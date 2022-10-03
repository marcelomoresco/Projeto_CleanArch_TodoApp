import 'package:todoapp_clean_project/src/features/todo_app/domain/entities/user_entity.dart';

import '../repositories/firebase_repository.dart';

class GetCreateCurrentUserUsecase {
  final FirebaseRepository firebaseRepository;

  GetCreateCurrentUserUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return firebaseRepository.getCreateCurrentUser(user);
  }
}
