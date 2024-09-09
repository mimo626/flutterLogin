class SignupUser {
  final String email;
  final String? password;
  final String? nickname;

  SignupUser(
    {
    required this.email,
      this.password,
      this.nickname,
  });
}
