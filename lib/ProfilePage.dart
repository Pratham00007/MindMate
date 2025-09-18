import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Header
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
                    'Your Name',
                    style: gfonts.GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate(delay: 400.ms).fadeIn().slideY(),
                  Text(
                    'Member since Jan 2024',
                    style: gfonts.GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ).animate(delay: 500.ms).fadeIn().slideY(),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms).slideY(),

            const SizedBox(height: 30),

            // Stats Cards
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

            // Menu Items
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    Icons.person_outline,
                    'Edit Profile',
                    () {},
                  ).animate(delay: 800.ms).slideX(),
                  _buildMenuItem(
                    Icons.notifications_outlined,
                    'Notifications',
                    () {},
                  ).animate(delay: 900.ms).slideX(),
                  _buildMenuItem(
                    Icons.history,
                    'Session History',
                    () {},
                  ).animate(delay: 1000.ms).slideX(),
                  _buildMenuItem(
                    Icons.favorite_outline,
                    'Saved Content',
                    () {},
                  ).animate(delay: 1100.ms).slideX(),
                  _buildMenuItem(
                    Icons.settings_outlined,
                    'Settings',
                    () {},
                  ).animate(delay: 1200.ms).slideX(),
                  _buildMenuItem(
                    Icons.help_outline,
                    'Help & Support',
                    () {},
                  ).animate(delay: 1300.ms).slideX(),
                  _buildMenuItem(
                    Icons.privacy_tip_outlined,
                    'Privacy Policy',
                    () {},
                  ).animate(delay: 1400.ms).slideX(),
                  _buildMenuItem(
                    Icons.logout,
                    'Logout',
                    () {},
                    isLogout: true,
                  ).animate(delay: 1500.ms).slideX(),
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
