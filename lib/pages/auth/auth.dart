import 'package:e_mosque/components/alert.dart';
import 'package:e_mosque/controllers/auth_controller.dart';
import 'package:e_mosque/pages/auth/forget_password.dart';
import 'package:e_mosque/pages/auth/verify_username.dart';
import 'package:e_mosque/pages/home/home.dart';
import 'package:e_mosque/provider/user_provider.dart';
import 'package:e_mosque/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_currentPage != 0) {
                                setState(() {
                                  _currentPage = 0;
                                  _pageController.animateToPage(
                                    0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: _currentPage == 0
                                    ? AppColors.primaryGradient
                                    : null,
                                color: _currentPage == 0
                                    ? null
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _currentPage == 0
                                        ? Colors.white
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_currentPage != 1) {
                                setState(() {
                                  _currentPage = 1;
                                  _pageController.animateToPage(
                                    1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: _currentPage == 1
                                    ? AppColors.primaryGradient
                                    : null,
                                color: _currentPage == 1
                                    ? null
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _currentPage == 1
                                        ? Colors.white
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        if (_currentPage != page) {
                          setState(() {
                            _currentPage = page;
                          });
                        }
                      },
                      children: [
                        buildSignIn(userProvider),
                        buildRegister(userProvider),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Center(
                  //   child: Text(
                  //     'Atau masuk dengan',
                  //     style: GoogleFonts.poppins(
                  //       fontSize: 14,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     socialMediaButton(
                  //       icon: Icons.facebook,
                  //       color: Color(0xFF3b5998),
                  //       onPressed: () {},
                  //     ),
                  //     SizedBox(width: 20),
                  //     socialMediaButton(
                  //       icon: Icons.g_mobiledata,
                  //       color: Color(0xFFDB4437),
                  //       onPressed: () {},
                  //     ),
                  //     SizedBox(width: 20),
                  //     socialMediaButton(
                  //       icon: Icons.apple,
                  //       color: Colors.black,
                  //       onPressed: () {},
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget socialMediaButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Ink(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
        shadows: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        iconSize: 36,
        onPressed: onPressed,
      ),
    );
  }
  Widget buildSignIn(UserProvider userProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        buildTextField(
          controller: _usernameController,
          hintText: 'Enter your email',
          prefixIcon: Icons.email,
        ),
        SizedBox(height: 20),
        Text(
          'Password',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        buildTextField(
          controller: _passwordController,
          hintText: 'Enter your password',
          prefixIcon: Icons.lock,
          obscureText: !_passwordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen()));
            },
            child: Text(
              'Lupa password?',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.greenColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final user = await _authController.login(
                _usernameController.text,
                _passwordController.text,
                context,
              );

              if (user != null) {
                userProvider.setUser(user);
                print("Navigating to Home");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              } else {
                print("Login failed, staying on login page");
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.greenColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Sign In',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRegister(UserProvider userProvider) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          buildTextField(
            controller: _usernameController,
            hintText: 'Enter your username',
            prefixIcon: Icons.person,
          ),
          SizedBox(height: 20),
          Text(
            'Name',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          buildTextField(
            controller: _nameController,
            hintText: 'Enter your name',
            prefixIcon: Icons.person_outline,
          ),
          SizedBox(height: 20),
          Text(
            'Phone',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          buildTextField(
            controller: _phoneController,
            hintText: 'Enter your phone number',
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 20),
          Text(
            'Email Address',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          buildTextField(
            controller: _emailController,
            hintText: 'Enter your email',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),
          Text(
            'Password',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          buildTextField(
            controller: _passwordController,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final result = await _authController.register(
                  _usernameController.text,
                  _nameController.text,
                  _phoneController.text,
                  _emailController.text,
                  _passwordController.text,
                  context,
                );

                if (result != null) {
                  userProvider.setUser(result);
                  print("Navigating to Home");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Register',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
