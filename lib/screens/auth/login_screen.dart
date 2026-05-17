import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../organization/organization_main_screen.dart';
import '../volunteer/volunteer_main_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();

  final FocusNode passwordFocus = FocusNode();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  Future<void> loginUser() async {
    String? result = await authService.login(
      email: emailController.text.trim(),

      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    if (result == null) {
      String role = await authService.getUserRole();

      if (!mounted) return;

      if (role == 'Volunteer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VolunteerMainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OrganizationMainScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              const SizedBox(height: 50),

              const Icon(
                Icons.volunteer_activism,
                size: 90,
                color: Colors.green,
              ),

              const SizedBox(height: 25),

              const Text(
                'Welcome Back',

                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                'Sign in to continue helping people',

                textAlign: TextAlign.center,

                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,

                focusNode: emailFocus,

                textInputAction: TextInputAction.next,

                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },

                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,

                focusNode: passwordFocus,

                obscureText: true,

                textInputAction: TextInputAction.done,

                onSubmitted: (_) {
                  loginUser();
                },

                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: loginUser,

                  child: const Text('Login'),
                ),
              ),

              const SizedBox(height: 25),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },

                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
