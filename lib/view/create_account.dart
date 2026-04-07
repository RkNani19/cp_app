import 'package:flutter/material.dart';
import 'package:gjk_cp/model/project_model.dart';
import 'package:gjk_cp/viewmodel/register_viewmodel.dart';
import 'package:provider/provider.dart';

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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController projectController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
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
                      TextSpan(
                        text: 'Kedia',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
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
                        controller: nameController,
                      ),
                      _buildInputField(
                        label: 'Mobile Number',
                        hint: 'Enter your mobile number',
                        icon: Icons.phone_outlined,
                        controller: mobileController,
                      ),
                      _buildInputField(
                        label: 'Email Address',
                        hint: 'Enter your email address',
                        icon: Icons.mail_outline,
                        controller: emailController,
                      ),
                      _buildInputField(
                        label: 'City',
                        hint: 'Enter your city',
                        icon: Icons.location_on_outlined,
                        controller: cityController,
                      ),
                     Consumer<RegisterViewModel>(
  builder: (context, vm, _) {

    // 🔥 Load API once
    if (vm.projectList.isEmpty) {
      vm.fetchProjects();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interested Project (Optional)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),

        DropdownButtonFormField<ProjectModel>(
          value: vm.selectedProject,
          isExpanded: true,

           dropdownColor: Colors.grey.shade100,
          hint: const Text("Select a project"),

          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.domain_outlined),

             filled: true, // 👈 enable background
    fillColor: Colors.white, 
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderGrey),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),

          items: vm.projectList.map((project) {
            return DropdownMenuItem<ProjectModel>(
              value: project,
              child: Text(project.projectName),
            );
          }).toList(),

          onChanged: (value) {
            if (value != null) {
              vm.setSelectedProject(value);
            }
          },
        ),
      ],
    );
  },
),
SizedBox(height: 8,),
                      _buildInputField(
                        label: 'Create Secret Key',
                        hint: 'Create a secret key (min 6 ch...)',
                        icon: Icons.vpn_key_outlined,
                        isPassword: true,
                        controller: passwordController,
                      ),
                      _buildInputField(
                        label: 'Confirm Secret Key',
                        hint: 'Confirm your secret key',
                        icon: Icons.vpn_key_outlined,
                        isPassword: true,
                        isLast: true,
                        controller: confirmPasswordController,
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
                                style: TextStyle(
                                  color: textGrey,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      color: primaryDarkBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(text: ' and\n'),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: primaryDarkBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                          onPressed: () async {
                            if (!_agreedToTerms) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Accept Terms & Conditions"),
                                ),
                              );
                              return;
                            }

                            final vm = Provider.of<RegisterViewModel>(
                              context,
                              listen: false,
                            );

                            final response = await vm.register(
                              endpoint: "customerapp/newregister",
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              mobile: mobileController.text.trim(),
                              password: passwordController.text.trim(),
                              confirmPassword: confirmPasswordController.text
                                  .trim(),
                              city: cityController.text.trim(),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response.msg)),
                            );
                          },
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
                        style: TextStyle(
                          color: accentGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Bottom Info Box ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
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
    TextEditingController? controller,
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
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderGrey),
            ),

            child: isDropdown
    ? Consumer<RegisterViewModel>(
        builder: (context, vm, _) {
          return InkWell(
            onTap: () async {

              final viewModel = Provider.of<RegisterViewModel>(
                  context,
                  listen: false);

              // ✅ Fetch API
              if (viewModel.projectList.isEmpty) {
                await viewModel.fetchProjects();
              }

              // ✅ OPEN FULL BOTTOM SHEET
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) {
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: viewModel.projectList.length,
                      itemBuilder: (context, index) {
                        final project =
                            viewModel.projectList[index];

                        return ListTile(
                          title: Text(project.projectName),
                          onTap: () {
                            viewModel.setSelectedProject(project);

                            if (controller != null) {
                              controller.text =
                                  project.projectName;
                            }

                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },

            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16, horizontal: 12),
              child: Row(
                children: [
                  Icon(icon,
                      color: const Color(0xFFA6AEBD), size: 22),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      (controller != null &&
                              controller.text.isNotEmpty)
                          ? controller.text
                          : hint,
                      style: TextStyle(
                        color: (controller != null &&
                                controller.text.isNotEmpty)
                            ? Colors.black
                            : const Color(0xFFA6AEBD),
                      ),
                    ),
                  ),

                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          );
        },
      )
                // 🔽 NORMAL FIELD
                : TextField(
                    controller: controller,
                    obscureText: isPassword,
                    decoration: InputDecoration(
                      hintText: hint,
                      prefixIcon: Icon(icon),
                      border: InputBorder.none,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
