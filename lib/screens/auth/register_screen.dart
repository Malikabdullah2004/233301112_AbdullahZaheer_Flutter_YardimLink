import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode nameFocus = FocusNode();

  final FocusNode emailFocus = FocusNode();

  final FocusNode passwordFocus = FocusNode();

  String selectedRole = 'Volunteer';

  final AuthService authService = AuthService();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  Future<void> registerUser() async {
    String? result = await authService.register(
      name: nameController.text.trim(),

      email: emailController.text.trim(),

      password: passwordController.text.trim(),

      role: selectedRole,
    );

    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration successful')));

      Navigator.pop(context);
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
              const SizedBox(height: 40),

              const Icon(Icons.favorite, size: 90, color: Colors.green),

              const SizedBox(height: 25),

              const Text(
                'Create Account',

                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                'Join the volunteer community today',

                textAlign: TextAlign.center,

                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: nameController,

                focusNode: nameFocus,

                textInputAction: TextInputAction.next,

                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(emailFocus);
                },

                decoration: const InputDecoration(
                  labelText: 'Full Name',

                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

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
                  registerUser();
                },

                decoration: const InputDecoration(
                  labelText: 'Password',

                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: selectedRole,

                decoration: const InputDecoration(
                  labelText: 'Select Role',

                  prefixIcon: Icon(Icons.badge),
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'Volunteer',
                    child: Text('Volunteer'),
                  ),

                  DropdownMenuItem(
                    value: 'Organization',
                    child: Text('Organization'),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: registerUser,

                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
