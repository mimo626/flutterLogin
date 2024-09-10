class SignupUserModel {
  final String email;
  final String password;
  final String nickname;

  SignupUserModel({
    required this.email,
    required this.password,
    required this.nickname,
  });

  // 데이터 모델을 Firestore나 API로 변환하는 메서드
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'nickname': nickname,
    };
  }

  // Firestore나 API로부터 데이터를 받아 데이터 모델로 변환하는 메서드
  factory SignupUserModel.fromMap(Map<String, dynamic> map) {
    return SignupUserModel(
      email: map['email'],
      password: map['password'],
      nickname: map['nickname'],
    );
  }
}
