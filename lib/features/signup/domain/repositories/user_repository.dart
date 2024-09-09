
import 'package:login/features/signup/domain/entity/user.dart';

abstract class UserRepository {
  Future<void> signUp(User user);
}
