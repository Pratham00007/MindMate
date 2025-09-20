import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Your Name";
  String _email = "example@email.com";
  String _phone = "+91 9876543210";
  DateTime? _dob;

  void _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          name: _name,
          email: _email,
          phone: _phone,
          dob: _dob,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _name = result["name"];
        _email = result["email"];
        _phone = result["phone"];
        _dob = result["dob"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: const Color(0xFF667eea),
                    ),
                  ).animate().scale(delay: 200.ms, duration: 600.ms),
                  const SizedBox(height: 16),


                  Text(
                    _name,
                    style: gfonts.GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate(delay: 400.ms).fadeIn().slideY(),

                  const SizedBox(height: 8),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        _dob == null
                            ? "DOB not set"
                            : DateFormat("dd MMM yyyy").format(_dob!),
                        style: gfonts.GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms).slideY(),

            const SizedBox(height: 30),


            Row(
              children: [
                Expanded(child: _buildStatCard('Sessions', '12', Colors.blue)),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard('Streak', '7 days', Colors.green),
                ),
                const SizedBox(width: 15),
                Expanded(child: _buildStatCard('Mood', 'Good', Colors.orange)),
              ],
            ).animate(delay: 600.ms).fadeIn().slideY(),

            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(Icons.notifications_outlined, 'Notifications', () {}),
                  _buildMenuItem(Icons.history, 'Session History', () {}),
                  _buildMenuItem(Icons.favorite_outline, 'Saved Content', () {}),
                  _buildMenuItem(Icons.settings_outlined, 'Settings', _openEditProfile),
                  _buildMenuItem(Icons.help_outline, 'Help & Support', () {}),
                  _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy Policy', () {}),
                  _buildMenuItem(Icons.logout, 'Logout', () {}, isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: gfonts.GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: gfonts.GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : const Color(0xFF00BFA5),
        ),
        title: Text(
          title,
          style: gfonts.GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : const Color(0xFF2E3A47),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }
}

// -------------------- Edit Profile Page --------------------

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final DateTime? dob;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    this.dob,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _dob = widget.dob;
  }

  void _saveChanges() {
    Navigator.pop(context, {
      "name": _nameController.text,
      "email": _emailController.text,
      "phone": _phoneController.text,
      "dob": _dob,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFF667eea),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: "Phone",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: const Icon(Icons.cake),
              title: Text(
                _dob == null
                    ? "Select Date of Birth"
                    : DateFormat("dd MMM yyyy").format(_dob!),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _dob ?? DateTime(2000, 1, 1),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _dob = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667eea),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
