class RegisterParam {
  final String name;
  final String email;
  final String password;
  String? photoProfile;

  RegisterParam({
    required this.name,
    required this.email,
    required this.password,
    this.photoProfile,
  });
}
