import 'package:flutter/material.dart';
import 'package:gcgrid/AppointmentPage.dart';
import 'package:gcgrid/Chat_Screen.dart';
import 'package:gcgrid/Community_page.dart';
import 'package:gcgrid/ProfilePage.dart';
import 'package:gcgrid/homepage.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

void main() {
  runApp(const GGGridApp());
}

class GGGridApp extends StatelessWidget {
  const GGGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GG Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: gfonts.GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: const Color(0xFFF8FFFE),
      ),
      home: const ConnectionChecker(), // ✅ Wrapped entry
    );
  }
}

// ✅ Internet checker wrapper
class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({super.key});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  bool _isConnected = true;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _checkConnection();

    // ✅ Listen for connectivity changes (handles List<ConnectivityResult>)
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (results.isNotEmpty) {
        _updateConnectionStatus(results.first);
      } else {
        _updateConnectionStatus(ConnectivityResult.none);
      }
    });
  }

  Future<void> _checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result.isNotEmpty) {
      _updateConnectionStatus(result.first);
    } else {
      _updateConnectionStatus(ConnectivityResult.none);
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) {
      return const MainScreen(); // ✅ load your app
    } else {
      return const NoInternetScreen(); // ✅ show loading when offline
    }
  }
}

// ✅ Offline screen
class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.teal),
            const SizedBox(height: 20),
            Text(
              "Waiting for Internet Connection...",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.home_rounded,
    Icons.groups_rounded,
    Icons.calendar_today_rounded,
    Icons.person_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _fabAnimationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _borderRadiusAnimationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(borderRadiusCurve);

    _hideBottomBarAnimationController =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    Future.delayed(const Duration(seconds: 1), () => _fabAnimationController.forward());
    Future.delayed(const Duration(seconds: 1), () => _borderRadiusAnimationController.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00BFA5),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const ChatScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: animation.drive(
                    Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeOut)),
                  ),
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.psychology_rounded, color: Colors.white),
      ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.white,
        activeColor: const Color(0xFF00BFA5),
        inactiveColor: Colors.grey,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const CommunityPage();
      case 2:
        return const AppointmentPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _borderRadiusAnimationController.dispose();
    _hideBottomBarAnimationController.dispose();
    super.dispose();
  }
}
