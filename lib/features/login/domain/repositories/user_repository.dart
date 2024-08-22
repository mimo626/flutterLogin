import 'package:login/features/login/domain/model/user.dart';

abstract class UserRepository {
  Future<void> signUp(User user);
}
