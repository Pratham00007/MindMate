
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:flutter_animate/flutter_animate.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Friend! 👋',
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E3A47),
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideX(),
                    Text(
                      'How are you feeling today?',
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideX(),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF00BFA5),
                  ),
                ).animate(delay: 400.ms).scale(),
              ],
            ),
            const SizedBox(height: 30),

            // Mood Check Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00ACC1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00BFA5).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Mood Check',
                    style: gfonts.GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track your emotional wellbeing',
                    style: gfonts.GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMoodButton('😢', 'Sad'),
                      _buildMoodButton('😐', 'Okay'),
                      _buildMoodButton('😊', 'Good'),
                      _buildMoodButton('😄', 'Great'),
                    ],
                  ),
                ],
              ),
            ).animate(delay: 600.ms).fadeIn(duration: 800.ms).slideY(),

            const SizedBox(height: 30),

            Text(
              'Mental Wellness Tools',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E3A47),
              ),
            ).animate(delay: 800.ms).fadeIn().slideX(),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildFeatureCard(
                    'Breathing Exercise',
                    '🧘‍♀️',
                    Colors.blue,
                    () {},
                  ).animate(delay: 1000.ms).scale(),
                  _buildFeatureCard(
                    'Meditation',
                    '🕉️',
                    Colors.purple,
                    () {},
                  ).animate(delay: 1100.ms).scale(),
                  _buildFeatureCard(
                    'Journal',
                    '📝',
                    Colors.orange,
                    () {},
                  ).animate(delay: 1200.ms).scale(),
                  _buildFeatureCard(
                    'Sleep Stories',
                    '🌙',
                    Colors.indigo,
                    () {},
                  ).animate(delay: 1300.ms).scale(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodButton(String emoji, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: gfonts.GoogleFonts.poppins(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    String title,
    String emoji,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: gfonts.GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E3A47),
              ),
            ),
          ],
        ),
      ),
    );
  }
}