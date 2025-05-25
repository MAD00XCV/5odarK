import 'package:app/models/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _selectedRole = 'Client';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  int getRoleValue() {
    return _selectedRole == 'Client' ? 0 : 1;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final signup = Signup(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
      address: _addressController.text.trim(),
      role: getRoleValue(),
    );

    final api = ApiService(baseUrl: "https://your-api-url.com/api/register");

    try {
      final response = await api.post(signup.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        // نجح التسجيل
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('register_success'.tr())),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('register_failed'.tr())),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error_occurred'.tr())),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF74B625),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'register'.tr(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242422),
                    ),
                  ),
                  const SizedBox(height: 20),

                  buildTextField(
                    controller: _nameController,
                    hint: 'full_name'.tr(),
                    icon: Icons.person,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'required'.tr() : null,
                  ),
                  const SizedBox(height: 16),

                  buildTextField(
                    controller: _emailController,
                    hint: 'email'.tr(),
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'required'.tr() : null,
                  ),
                  const SizedBox(height: 16),

                  buildPasswordField(
                    controller: _passwordController,
                    label: 'password'.tr(),
                    icon: Icons.lock,
                    obscure: _obscurePassword,
                    onToggle: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  const SizedBox(height: 16),

                  buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'confirm_password'.tr(),
                    icon: Icons.lock_outline,
                    obscure: _obscureConfirmPassword,
                    onToggle: () => setState(
                        () => _obscureConfirmPassword = !_obscureConfirmPassword),
                    validator: (v) => v != _passwordController.text
                        ? 'passwords_do_not_match'.tr()
                        : null,
                  ),
                  const SizedBox(height: 16),

                  buildTextField(
                    controller: _phoneController,
                    hint: 'mobile_optional'.tr(),
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  buildTextField(
                    controller: _addressController,
                    hint: 'address_optional'.tr(),
                    icon: Icons.location_on,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          color: Color(0xFF242422)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedRole,
                          items: ['Client', 'Farmer']
                              .map((role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role.tr()),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _selectedRole = value!),
                          decoration: InputDecoration(
                            hintText: 'select_role'.tr(),
                            filled: true,
                            fillColor: const Color(0xFFD3EB92),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF74B625),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'create_account'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'already_have_account'.tr(),
                      style: const TextStyle(color: Color(0xFF242422)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFD3EB92),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF242422)),
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: const Color(0xFFD3EB92),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF242422)),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF242422),
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
