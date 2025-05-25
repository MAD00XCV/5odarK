class Signup {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;
  final String address;
  final int role;

  Signup({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    required this.address,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'address': address,
      'role': role,
    };
  }
}
