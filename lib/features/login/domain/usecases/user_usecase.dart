import 'package:login/features/login/domain/entity/user.dart';
import 'package:login/features/login/domain/repositories/user_repository.dart';


class UserUsecase {
  final UserRepository repository;

  UserUsecase(this.repository);

  Future<void> execute(String email, String password, String nickname) async {
    final user = User(email: email, password: password);
    await repository.signUp(user);
  }

}
