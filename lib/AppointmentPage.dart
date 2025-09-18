import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:flutter_animate/flutter_animate.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book Appointment 📅',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E3A47),
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(),
            const SizedBox(height: 8),
            Text(
              'Connect with licensed psychiatrists',
              style: gfonts.GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideX(),
            const SizedBox(height: 30),

            // Quick Booking Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFff7b7b), Color(0xFFff9a9e)],
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
                          'Emergency Support',
                          style: gfonts.GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Immediate help available 24/7',
                          style: gfonts.GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFFff7b7b),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Call Now',
                            style: gfonts.GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.emergency, size: 50, color: Colors.white),
                ],
              ),
            ).animate(delay: 400.ms).fadeIn().slideY(),

            const SizedBox(height: 30),

            Text(
              'Available Psychiatrists',
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
                  _buildDoctorCard(
                    'Dr. Priya Sharma',
                    'Clinical Psychologist',
                    '15 years experience',
                    '₹1,200/session',
                    '4.9',
                    'Available Today',
                    Colors.blue,
                  ).animate(delay: 800.ms).fadeIn().slideX(),
                  _buildDoctorCard(
                    'Dr. Rajesh Kumar',
                    'Psychiatrist',
                    '12 years experience',
                    '₹1,500/session',
                    '4.8',
                    'Next: Tomorrow 2PM',
                    Colors.green,
                  ).animate(delay: 900.ms).fadeIn().slideX(),
                  _buildDoctorCard(
                    'Dr. Anita Mehta',
                    'Counseling Psychologist',
                    '8 years experience',
                    '₹1,000/session',
                    '4.7',
                    'Available Today',
                    Colors.purple,
                  ).animate(delay: 1000.ms).fadeIn().slideX(),
                  _buildDoctorCard(
                    'Dr. Vikram Singh',
                    'Child Psychiatrist',
                    '10 years experience',
                    '₹1,300/session',
                    '4.9',
                    'Next: Today 6PM',
                    Colors.orange,
                  ).animate(delay: 1100.ms).fadeIn().slideX(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(
    String name,
    String specialization,
    String experience,
    String fee,
    String rating,
    String availability,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(Icons.person, size: 30, color: color),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2E3A47),
                      ),
                    ),
                    Text(
                      specialization,
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: gfonts.GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF2E3A47),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience,
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fee,
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      availability,
                      style: gfonts.GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      'Book Now',
                      style: gfonts.GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
