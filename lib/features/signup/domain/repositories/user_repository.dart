
import 'package:login/features/signup/domain/entity/signup_user.dart';

abstract class UserRepository {
  Future<void> signUp(SignupUser user);
}
