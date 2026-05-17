import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import '../organization/organization_main_screen.dart';
import '../volunteer/volunteer_main_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<Widget> getScreen() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const LoginScreen();
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    String role = userDoc['role'];

    if (role == 'Volunteer') {
      return const VolunteerMainScreen();
    } else {
      return const OrganizationMainScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return snapshot.data!;
      },
    );
  }
}
