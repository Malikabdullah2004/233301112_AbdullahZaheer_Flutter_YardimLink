import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final String userId =
        FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<DocumentSnapshot>(

      future:
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get(),

      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData ||
            !snapshot.data!.exists) {

          return const Center(
            child: Text(
              'User data not found',
            ),
          );
        }

        final userData =
            snapshot.data!;

        return SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),

              const SizedBox(height: 30),

              Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.person),
                  title: const Text('Name'),
                  subtitle: Text(
                    userData['name'],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(
                    userData['email'],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.badge),
                  title: const Text('Role'),
                  subtitle: Text(
                    userData['role'],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child:
                    ElevatedButton.icon(

                  onPressed: () async {

                    await AuthService()
                        .logout();

                    if (!context.mounted) {
                      return;
                    }

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },

                  icon:
                      const Icon(Icons.logout),

                  label:
                      const Text('Logout'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}