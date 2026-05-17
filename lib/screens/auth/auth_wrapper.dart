import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../organization/organization_main_screen.dart';
import '../volunteer/volunteer_main_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {

  const AuthWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream:
          FirebaseAuth.instance
              .authStateChanges(),

      builder: (context, snapshot) {

        // LOADING

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child:
                  CircularProgressIndicator(),
            ),
          );
        }

        // NOT LOGGED IN

        if (!snapshot.hasData) {

          return const LoginScreen();
        }

        // USER LOGGED IN

        return FutureBuilder<DocumentSnapshot>(

          future:
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),

          builder: (
            context,
            userSnapshot,
          ) {

            if (userSnapshot.connectionState ==
                ConnectionState.waiting) {

              return const Scaffold(
                body: Center(
                  child:
                      CircularProgressIndicator(),
                ),
              );
            }

            if (!userSnapshot.hasData ||
                !userSnapshot.data!.exists) {

              return const Scaffold(
                body: Center(
                  child: Text(
                    'User data not found',
                  ),
                ),
              );
            }

            final userData =
                userSnapshot.data!;

            final role =
                userData['role'];

            // VOLUNTEER

            if (role == 'Volunteer') {

              return const VolunteerMainScreen();
            }

            // ORGANIZATION

            return const OrganizationMainScreen();
          },
        );
      },
    );
  }
}