import 'package:login/features/signup/domain/entity/signup_user.dart';
import 'package:login/features/signup/domain/repositories/user_repository.dart';


class UserUsecase {
  final UserRepository repository;

  UserUsecase(this.repository);

  Future<void> execute(String email, String password, String nickname) async {
    final user = SignupUser(email: email, password: password);
    await repository.signUp(user);
  }

}
