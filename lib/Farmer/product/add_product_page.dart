import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class FarmerAddProductPage extends StatefulWidget {
  const FarmerAddProductPage({super.key});

  @override
  State<FarmerAddProductPage> createState() => _FarmerAddProductPageState();
}

class _FarmerAddProductPageState extends State<FarmerAddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  void _submitProduct() {
    if (_formKey.currentState!.validate()) {
      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Farmer_J.choose_image'.tr())),
        );
        return;
      }

      // هنا ممكن تضيف عملية رفع المنتج فعليًا
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Farmer_J.product_added_success'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        title: Text(
          'Farmer_J.add_product'.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFF74B625),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3EB92),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_imageFile!, fit: BoxFit.cover),
                          )
                        : Center(
                            child: Text(
                              'Farmer_J.choose_image'.tr(),
                              style: const TextStyle(color: Color(0xFF242422)),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                _buildField(_nameController, 'Farmer_J.product_name'),
                _buildField(_descController, 'Farmer_J.product_description'),
                _buildField(_addressController, 'Farmer_J.product_address'),
                _buildField(_priceController, 'Farmer_J.product_price', keyboardType: TextInputType.number),
                _buildField(_unitController, 'Farmer_J.product_unit'),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF74B625),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Farmer_J.submit'.tr(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String labelKey,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? 'Farmer_J.required_field'.tr() : null,
        decoration: InputDecoration(
          hintText: labelKey.tr(),
          filled: true,
          fillColor: const Color(0xFFD3EB92),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
