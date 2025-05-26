import 'package:app/Farmer/profile/edit_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:app/login_register/login_page.dart';

class FarmerProfilePage extends StatelessWidget {
  const FarmerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF74B625);
    const bgColor = Color(0xFFEEF2E3);
    const fieldColor = Color(0xFFD3EB92);
    const textColor = Color(0xFF242422);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          tr('profile'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 64,
              backgroundColor: primaryColor,
              child: const CircleAvatar(
                radius: 60,
                foregroundImage: AssetImage('assets/images/con1.png'),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              "farmer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Center(
            child: Text(
              "farmer120@gmail.com",
              style: TextStyle(
                fontSize: 14,
                // ignore: deprecated_member_use
                color: textColor.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildProfileOption(
            icon: IconlyLight.profile,
            title: tr('edit_profile'),
            backgroundColor: fieldColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileFarmerPage()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildProfileOption(
            icon: IconlyLight.infoSquare,
            title: tr('about_privacy_title'),
            backgroundColor: fieldColor,
            onTap: () {
              _showAboutPrivacyDialog(context);
            },
          ),
          const SizedBox(height: 12),
          _buildProfileOption(
            icon: IconlyLight.setting,
            title: tr('change_language'),
            backgroundColor: fieldColor,
            onTap: () {
              final currentLocale = context.locale;
              if (currentLocale.languageCode == 'en') {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
            },
          ),
          const SizedBox(height: 12),
          _buildProfileOption(
            icon: IconlyLight.logout,
            title: tr('logout'),
            backgroundColor: fieldColor,
            titleColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
          const SizedBox(height: 30),
          Text(
            "Version 1.0.0",
            textAlign: TextAlign.center,
            // ignore: deprecated_member_use
            style: TextStyle(color: textColor.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required Color backgroundColor,
    Color titleColor = const Color(0xFF242422),
    Color iconColor = const Color(0xFF242422),
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: backgroundColor.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showAboutPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF7FBE7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF74B625), width: 2),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr('about_privacy_title'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF74B625),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    tr('about_privacy_content'),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF242422),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF74B625),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      tr('ok'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF7FBE7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF74B625), width: 2),
          ),
          title: Text(
            tr('logout'),
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            tr('logout_confirm'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF242422),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                tr('no'),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: Text(
                tr('yes'),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
