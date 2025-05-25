import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(text: "Manar Yasser");
  final TextEditingController emailController = TextEditingController(text: "manary960@gmail.com");
  final TextEditingController phoneController = TextEditingController(text: "01012345678");
  final TextEditingController addressController = TextEditingController(text: "Nasr City, Cairo");

  static const primaryColor = Color(0xFF74B625);
  static const bgColor = Color(0xFFEEF2E3);
  static const fieldColor = Color(0xFFD3EB92);
  static const textColor = Color(0xFF242422);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('edit_profile'.tr()),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: nameController,
                label: 'full_name'.tr(),
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: emailController,
                label: 'email'.tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: phoneController,
                label: 'mobile_optional'.tr(),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: addressController,
                label: 'address_optional'.tr(),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('profile_updated'.tr())),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'save'.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => (value == null || value.isEmpty) ? 'required_field'.tr() : null,
    );
  }
}
