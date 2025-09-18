import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:flutter_animate/flutter_animate.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Community Support 🤝',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E3A47),
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(),
            const SizedBox(height: 8),
            Text(
              'Connect with others who understand',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideX(),
            const SizedBox(height: 30),

            // Join Community Section
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join Our Community',
                          style: gfonts.GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Share experiences & support each other',
                          style: gfonts.GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.group_add, size: 40, color: Colors.white),
                ],
              ),
            ).animate(delay: 400.ms).fadeIn().slideY(),

            const SizedBox(height: 30),

            Text(
              'Support Groups',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E3A47),
              ),
            ).animate(delay: 600.ms).fadeIn().slideX(),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  _buildGroupCard(
                    'Student Support Circle',
                    'For students dealing with academic stress',
                    '1.2k members',
                    '🎓',
                    Colors.blue,
                  ).animate(delay: 800.ms).fadeIn().slideX(),
                  _buildGroupCard(
                    'Anxiety & Depression Support',
                    'Safe space for mental health discussions',
                    '856 members',
                    '🫂',
                    Colors.green,
                  ).animate(delay: 900.ms).fadeIn().slideX(),
                  _buildGroupCard(
                    'Young Professionals',
                    'Career stress and work-life balance',
                    '642 members',
                    '💼',
                    Colors.orange,
                  ).animate(delay: 1000.ms).fadeIn().slideX(),
                  _buildGroupCard(
                    'Mindfulness & Meditation',
                    'Practice mindfulness together',
                    '394 members',
                    '🧘‍♀️',
                    Colors.purple,
                  ).animate(delay: 1100.ms).fadeIn().slideX(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(
    String title,
    String description,
    String memberCount,
    String emoji,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: gfonts.GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E3A47),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: gfonts.GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  memberCount,
                  style: gfonts.GoogleFonts.poppins(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Join',
              style: gfonts.GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
