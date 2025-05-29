// lib/features/auth/data/models/signup_model.dart

class Signin {
  final int? id;
  final String email;
  final String password;

  Signin({
    this.id,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
