import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class FarmerEditProductPage extends StatefulWidget {
  const FarmerEditProductPage({super.key, required Map<String, dynamic> product});

  @override
  State<FarmerEditProductPage> createState() => _FarmerEditProductPageState();
}

class _FarmerEditProductPageState extends State<FarmerEditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _unitController;
  late TextEditingController _addressController;

  File? _image;
  String? _imageUrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _nameController = TextEditingController(text: product['name']);
    _descriptionController = TextEditingController(text: product['description']);
    _priceController = TextEditingController(text: product['price']);
    _unitController = TextEditingController(text: product['unit']);
    _addressController = TextEditingController(text: product['address']);
    _imageUrl = product['image'];
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // هنا ممكن تبعت الداتا للسيرفر أو تحدث القائمة
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF74B625),
        foregroundColor: Colors.white,
        title: Text(
          'Farmer_J.edit_product'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _image != null
                        ? Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover)
                        : Image.network(_imageUrl!, height: 200, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField(_nameController, 'Farmer_J.product_name'.tr()),
              const SizedBox(height: 12),
              _buildTextField(_descriptionController, 'Farmer_J.product_description'.tr(), maxLines: 3),
              const SizedBox(height: 12),
              _buildTextField(_priceController, 'Farmer_J.product_price'.tr(), keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              _buildTextField(_unitController, 'Farmer_J.product_unit'.tr()),
              const SizedBox(height: 12),
              _buildTextField(_addressController, 'Farmer_J.product_address'.tr()),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF74B625),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Farmer_J.save'.tr(), style: const TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? 'validation.required'.tr() : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
