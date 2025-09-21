import 'package:flutter/material.dart';
import 'package:gcgrid/pages/services/pin_service.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_animate/flutter_animate.dart';


class PinSetupPage extends StatefulWidget {
  final bool isSetup; // true for setup, false for verification
  final VoidCallback? onSuccess;
  
  const PinSetupPage({
    super.key,
    this.isSetup = true,
    this.onSuccess,
  });

  @override
  State<PinSetupPage> createState() => _PinSetupPageState();
}

class _PinSetupPageState extends State<PinSetupPage> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  
  String _currentPin = "";
  String _confirmPin = "";
  bool _isConfirmStep = false;
  bool _isLoading = false;
  String _errorMessage = "";

  Future<void> _handlePinComplete(String pin) async {
    setState(() {
      _errorMessage = "";
    });

    if (widget.isSetup) {
      // Setup mode
      if (!_isConfirmStep) {
        // First PIN entry
        setState(() {
          _currentPin = pin;
          _isConfirmStep = true;
        });
        _confirmPinController.clear();
      } else {
        // Confirm PIN entry
        if (pin == _currentPin) {
          setState(() {
            _isLoading = true;
          });
          
          bool success = await PinService.setPin(pin);
          
          if (success && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('App lock PIN set successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            if (widget.onSuccess != null) {
              widget.onSuccess!();
            } else {
              Navigator.pop(context, true);
            }
          } else if (mounted) {
            setState(() {
              _errorMessage = "Failed to set PIN. Please try again.";
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _errorMessage = "PINs don't match. Please try again.";
            _confirmPinController.clear();
          });
        }
      }
    } else {
      // Verification mode
      setState(() {
        _isLoading = true;
      });
      
      bool isCorrect = await PinService.verifyPin(pin);
      
      if (isCorrect && mounted) {
        if (widget.onSuccess != null) {
          widget.onSuccess!();
        } else {
          Navigator.pop(context, true);
        }
      } else if (mounted) {
        setState(() {
          _errorMessage = "Incorrect PIN. Please try again.";
          _pinController.clear();
          _isLoading = false;
        });
      }
    }
  }

  void _goBack() {
    if (widget.isSetup && _isConfirmStep) {
      setState(() {
        _isConfirmStep = false;
        _currentPin = "";
        _confirmPin = "";
        _errorMessage = "";
      });
      _pinController.clear();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2E3A47)),
          onPressed: _goBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // Lock icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outlined,
                  size: 60,
                  color: Color(0xFF00BFA5),
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              
              const SizedBox(height: 40),
              
              // Title
              Text(
                widget.isSetup
                    ? (_isConfirmStep ? 'Confirm Your PIN' : 'Set App Lock PIN')
                    : 'Enter Your PIN',
                style: gfonts.GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E3A47),
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 200.ms).fadeIn(duration: 600.ms),
              
              const SizedBox(height: 16),
              
              // Subtitle
              Text(
                widget.isSetup
                    ? (_isConfirmStep
                        ? 'Re-enter your 4-digit PIN to confirm'
                        : 'Create a 4-digit PIN to secure your app')
                    : 'Enter your 4-digit PIN to continue',
                style: gfonts.GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 400.ms).fadeIn(duration: 600.ms),
              
              const SizedBox(height: 60),
              
              // PIN input
              PinCodeTextField(
                appContext: context,
                length: 4,
                controller: widget.isSetup
                    ? (_isConfirmStep ? _confirmPinController : _pinController)
                    : _pinController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 4) {
                    return "Please enter 4 digits";
                  }
                  return null;
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: const Color(0xFF00BFA5),
                  inactiveColor: Colors.grey[300]!,
                  selectedColor: const Color(0xFF00BFA5),
                ),
                cursorColor: const Color(0xFF00BFA5),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: _isLoading ? null : _handlePinComplete,
                onChanged: (value) {
                  setState(() {
                    _errorMessage = "";
                  });
                },
              ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideY(),
              
              const SizedBox(height: 30),
              
              // Error message
              if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[600],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: gfonts.GoogleFonts.poppins(
                            color: Colors.red[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().shake(),
              
              const Spacer(),
              
              // Loading indicator
              if (_isLoading)
                const CircularProgressIndicator(
                  color: Color(0xFF00BFA5),
                ).animate().fadeIn(),
              
              const SizedBox(height: 20),
              
              // Skip option for setup
              if (widget.isSetup && !_isConfirmStep)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Skip for now',
                    style: gfonts.GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ).animate(delay: 800.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }
}