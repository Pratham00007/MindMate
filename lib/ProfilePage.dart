import 'package:flutter/material.dart';
import 'package:gcgrid/pages/services/auth_service.dart';
import 'package:gcgrid/pages/services/pin_service.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user_model.dart';
import 'pages/auth/pin_setup_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _currentUser;
  bool _isLoading = true;
  bool _isPinEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _checkPinStatus();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        UserModel? user = await AuthService.getUserData(firebaseUser.uid);
        setState(() {
          _currentUser = user;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkPinStatus() async {
    bool pinEnabled = await PinService.isPinEnabled();
    setState(() {
      _isPinEnabled = pinEnabled;
    });
  }

  void _openEditProfile() async {
    if (_currentUser == null) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(user: _currentUser!),
      ),
    );

    if (result == true) {
      _loadUserData(); // Reload user data after edit
    }
  }

  void _showSessionHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session History'),
        content: const Text('Feature coming soon! You\'ll be able to view your therapy session history here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSavedContent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saved Content'),
        content: const Text('Feature coming soon! Your saved articles, exercises, and resources will appear here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHelpSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Need help? Contact us:'),
            const SizedBox(height: 10),
            Text('📧 Email: support@ggrid.com'),
            Text('📞 Phone: +91 1800-123-456'),
            Text('🕒 Hours: 9 AM - 6 PM, Mon-Fri'),
            if (_currentUser?.emergencyContactName != null) ...[
              const SizedBox(height: 15),
              const Text('Emergency Contact:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${_currentUser!.emergencyContactName}'),
              Text('${_currentUser!.emergencyContactPhone}'),
              if (_currentUser!.emergencyContactRelation != null)
                Text('(${_currentUser!.emergencyContactRelation})'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Your privacy is important to us. We collect and use your information only to provide better mental health services.\n\n'
            '• Your real name is kept confidential\n'
            '• Anonymous username protects your identity\n'
            '• Emergency contacts are used only in crisis situations\n'
            '• All data is encrypted and securely stored\n'
            '• You can delete your account anytime\n\n'
            'For full privacy policy, visit our website.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Settings'),
        content: const Text('Notification preferences will be available soon. You\'ll be able to customize reminders and alerts.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _manageAppLock() async {
    if (_isPinEnabled) {
      // Show options to disable or change PIN
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('App Lock Settings'),
          content: const Text('What would you like to do with your app lock?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // Change PIN
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinSetupPage(
                      isSetup: true,
                      onSuccess: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('PIN changed successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: const Text('Change PIN'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                bool success = await PinService.disablePin();
                if (success) {
                  setState(() {
                    _isPinEnabled = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('App lock disabled'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              child: const Text('Disable', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    } else {
      // Set up PIN
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PinSetupPage(isSetup: true),
        ),
      );

      if (result == true) {
        setState(() {
          _isPinEnabled = true;
        });
      }
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await AuthService.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF00BFA5)),
        ),
      );
    }

    if (_currentUser == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Unable to load profile'),
              ElevatedButton(
                onPressed: _loadUserData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile header
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
                    child: Text(
                      _currentUser!.anonymousUsername.substring(0, 2).toUpperCase(),
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF667eea),
                      ),
                    ),
                  ).animate().scale(delay: 200.ms, duration: 600.ms),
                  
                  const SizedBox(height: 16),

                  Text(
                    _currentUser!.anonymousUsername,
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
                        _currentUser!.dob == null
                            ? "DOB not set"
                            : DateFormat("dd MMM yyyy").format(_currentUser!.dob!),
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

            // Stats cards
            Row(
              children: [
                Expanded(child: _buildStatCard('Sessions', _currentUser!.totalSessions.toString(), Colors.blue)),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard('Streak', '${_currentUser!.currentStreak} days', Colors.green),
                ),
                const SizedBox(width: 15),
                Expanded(child: _buildStatCard('Mood', _currentUser!.currentMood, Colors.orange)),
              ],
            ).animate(delay: 600.ms).fadeIn().slideY(),

            const SizedBox(height: 30),

            // Menu items
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(Icons.notifications_outlined, 'Notifications', _showNotificationSettings),
                  _buildMenuItem(Icons.history, 'Session History', _showSessionHistory),
                  _buildMenuItem(Icons.favorite_outline, 'Saved Content', _showSavedContent),
                  _buildMenuItem(Icons.edit_outlined, 'Edit Profile', _openEditProfile),
                  _buildMenuItem(
                    _isPinEnabled ? Icons.lock : Icons.lock_open_outlined,
                    _isPinEnabled ? 'App Lock (Enabled)' : 'Enable App Lock',
                    _manageAppLock,
                  ),
                  _buildMenuItem(Icons.help_outline, 'Help & Support', _showHelpSupport),
                  _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy Policy', _showPrivacyPolicy),
                  _buildMenuItem(Icons.logout, 'Logout', _logout, isLogout: true),
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
  final UserModel user;

  const EditProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _realNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _emergencyNameController;
  late TextEditingController _emergencyPhoneController;
  late TextEditingController _emergencyRelationController;
  DateTime? _dob;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _realNameController = TextEditingController(text: widget.user.realName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _emergencyNameController = TextEditingController(text: widget.user.emergencyContactName ?? '');
    _emergencyPhoneController = TextEditingController(text: widget.user.emergencyContactPhone ?? '');
    _emergencyRelationController = TextEditingController(text: widget.user.emergencyContactRelation ?? '');
    _dob = widget.user.dob;
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserModel updatedUser = widget.user.copyWith(
        realName: _realNameController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        dob: _dob,
        emergencyContactName: _emergencyNameController.text.trim().isEmpty ? null : _emergencyNameController.text.trim(),
        emergencyContactPhone: _emergencyPhoneController.text.trim().isEmpty ? null : _emergencyPhoneController.text.trim(),
        emergencyContactRelation: _emergencyRelationController.text.trim().isEmpty ? null : _emergencyRelationController.text.trim(),
      );

      bool success = await AuthService.updateUserData(updatedUser);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: gfonts.GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anonymous username display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00BFA5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person, color: Color(0xFF00BFA5)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anonymous Username',
                        style: gfonts.GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        widget.user.anonymousUsername,
                        style: gfonts.GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00BFA5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Basic Information Section
            Text(
              'Basic Information',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E3A47),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _realNameController,
              decoration: const InputDecoration(
                labelText: "Real Name (Private)",
                helperText: "Used only for appointments and emergencies",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _emailController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Email (Cannot be changed)",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone (Optional)",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
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
              trailing: const Icon(Icons.arrow_forward_ios),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: Colors.grey[400]!),
              ),
            ),

            const SizedBox(height: 30),

            // Emergency Contact Section
            Text(
              'Emergency Contact (Optional)',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E3A47),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _emergencyNameController,
              decoration: const InputDecoration(
                labelText: "Emergency Contact Name",
                prefixIcon: Icon(Icons.contact_emergency),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _emergencyPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Emergency Contact Phone",
                prefixIcon: Icon(Icons.phone_in_talk),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _emergencyRelationController,
              decoration: const InputDecoration(
                labelText: "Relationship (e.g., Parent, Spouse)",
                prefixIcon: Icon(Icons.family_restroom),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 40),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveChanges,
                icon: const Icon(Icons.save),
                label: Text(
                  _isLoading ? 'Saving...' : 'Save Changes',
                  style: gfonts.GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF667eea),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _realNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationController.dispose();
    super.dispose();
  }
}