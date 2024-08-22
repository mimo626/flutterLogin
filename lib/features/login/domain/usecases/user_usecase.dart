import 'package:login/features/login/domain/model/user.dart';
import 'package:login/features/login/domain/repositories/user_repository.dart';


class UserUsecase {
  final UserRepository repository;

  UserUsecase(this.repository);

  Future<void> execute(String email, String password, String nickname) async {
    final user = User(email: email, password: password, nickname: nickname);
    print("Usecase------------------------");
    await repository.signUp(user);
  }
}
