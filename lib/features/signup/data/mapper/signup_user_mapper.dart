import 'package:login/features/signup/data/model/signup_user_model.dart';
import 'package:login/features/signup/domain/entity/signup_user.dart';

class SignupUserMapper {
  static SignupUserModel entityToModel(SignupUser entity) {
    return SignupUserModel(
      email: entity.email,
      password: entity.password,
      nickname: entity.nickname,
    );
  }

  // 데이터 모델을 도메인 엔티티로 변환
  static SignupUser modelToEntity(SignupUserModel model) {
    return SignupUser(
      email: model.email,
      password: model.password,
      nickname: model.nickname,
    );
  }
}
