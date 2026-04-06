import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key, required this.title});
  final String title;

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // --- Exact Color Codes from Design ---
  final Color bgColor = const Color(0xFFF3F5F9);
  final Color primaryDarkBlue = const Color(0xFF021148);
  final Color accentGold = const Color(0xFFC8A573);
  final Color textGrey = const Color(0xFF7B8599);
  final Color borderGrey = const Color(0xFFE2E6ED);
  final Color infoBoxBg = const Color(0xFFE1E4EA);
  
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                
                // --- Logo Header Section ---
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: primaryDarkBlue,
                      letterSpacing: -0.5,
                    ),
                    children: const [
                      TextSpan(text: 'GJ'),
                      TextSpan(text: 'Kedia', style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'H O M E S',
                  style: TextStyle(
                    color: accentGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 4.0,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Create Your Customer Account',
                  style: TextStyle(
                    color: Color(0xFF5A667E),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // --- Main Form Card ---
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register Now',
                        style: TextStyle(
                          color: primaryDarkBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill in your details to create an\naccount',
                        style: TextStyle(
                          color: textGrey,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // --- Form Fields ---
                      _buildInputField(
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline,
                      ),
                      _buildInputField(
                        label: 'Mobile Number',
                        hint: 'Enter your mobile number',
                        icon: Icons.phone_outlined,
                      ),
                      _buildInputField(
                        label: 'Email Address',
                        hint: 'Enter your email address',
                        icon: Icons.mail_outline,
                      ),
                      _buildInputField(
                        label: 'City',
                        hint: 'Enter your city',
                        icon: Icons.location_on_outlined,
                      ),
                      _buildInputField(
                        label: 'Interested Project (Optional)',
                        hint: 'Select a project',
                        icon: Icons.domain_outlined,
                        isDropdown: true,
                      ),
                      _buildInputField(
                        label: 'Create Secret Key',
                        hint: 'Create a secret key (min 6 ch...)',
                        icon: Icons.vpn_key_outlined,
                        isPassword: true,
                      ),
                      _buildInputField(
                        label: 'Confirm Secret Key',
                        hint: 'Confirm your secret key',
                        icon: Icons.vpn_key_outlined,
                        isPassword: true,
                        isLast: true,
                      ),

                      const SizedBox(height: 20),

                      // --- Terms and Conditions Checkbox ---
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _agreedToTerms,
                              onChanged: (value) {
                                setState(() {
                                  _agreedToTerms = value ?? false;
                                });
                              },
                              activeColor: primaryDarkBlue,
                              side: BorderSide(color: accentGold, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: textGrey, fontSize: 13, height: 1.4),
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(color: primaryDarkBlue, fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(text: ' and\n'),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(color: primaryDarkBlue, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // --- Create Account Button ---
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Login Link ---
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: textGrey, fontSize: 14),
                    children: [
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Login Here',
                        style: TextStyle(color: accentGold, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Bottom Info Box ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: infoBoxBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "After registration, you'll receive a unique\nCustomer ID via SMS and Email. Use this ID\nalong with your secret key to login.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF657189),
                      fontSize: 12.5,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Reusable Widget for Form Fields ---
  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isDropdown = false,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderGrey, width: 1),
            ),
            child: TextField(
              obscureText: isPassword,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: const Color(0xFFA6AEBD), fontSize: 14),
                prefixIcon: Icon(icon, color: const Color(0xFFA6AEBD), size: 22),
                suffixIcon: isDropdown 
                    ? Icon(Icons.keyboard_arrow_down, color: const Color(0xFFA6AEBD)) 
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}