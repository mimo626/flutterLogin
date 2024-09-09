import 'package:login/features/login/domain/entity/user.dart';

abstract class UserRepository {
  Future<void> signUp(User user);
}
