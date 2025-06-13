import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:easy_localization/easy_localization.dart';

import 'card_checkout_page.dart';

class LocationPickerPage extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> cartItems;

  const LocationPickerPage({
    super.key,
    required this.totalAmount,
    required this.cartItems,
  });

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  LatLng? _selectedLocation;
  late GoogleMapController _mapController;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _manualAddressController = TextEditingController();
  final Location _locationService = Location();

  bool _useManualAddress = false;

  final Color primaryGreen = const Color(0xFF74B625);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final userLocation = await _locationService.getLocation();
      setState(() {
        _selectedLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
      });
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTapMap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _confirm() {
    if (_phoneController.text.isEmpty ||
        (_useManualAddress && _manualAddressController.text.isEmpty) ||
        (!_useManualAddress && _selectedLocation == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('fill_required_fields'.tr())),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardCheckoutPage(
          phone: _phoneController.text,
          location: _useManualAddress ? _manualAddressController.text : _selectedLocation,
          total: widget.totalAmount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF74B625),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1F1F1F)),
        title: Text(
          'location_page_title'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_useManualAddress && _selectedLocation != null)
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF74B625),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(color: primaryGreen, width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _selectedLocation!,
                      zoom: 16,
                    ),
                    onTap: _onTapMap,
                    markers: {
                      Marker(
                        markerId: const MarkerId('selected'),
                        position: _selectedLocation!,
                      ),
                    },
                  ),
                ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  'enter_manual_address'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                value: _useManualAddress,
                activeColor: primaryGreen,
                onChanged: (val) {
                  setState(() {
                    _useManualAddress = val;
                  });
                },
              ),
              if (_useManualAddress)
                _buildInputField(
                  controller: _manualAddressController,
                  hint: 'address'.tr(),
                  icon: Icons.home_outlined,
                ),
              const SizedBox(height: 12),
              _buildInputField(
                controller: _phoneController,
                hint: 'enter_phone'.tr(),
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 25),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _confirm,
                label: Text(
                  'next'.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF74B625),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(color: Color(0xFF74B625), width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}