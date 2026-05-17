import 'package:flutter/material.dart';

import '../shared/profile_screen.dart';
import '../shared/task_list_screen.dart';
import 'my_applications_screen.dart';

class VolunteerMainScreen
    extends StatefulWidget {

  const VolunteerMainScreen({
    super.key,
  });

  @override
  State<VolunteerMainScreen>
      createState() =>
          _VolunteerMainScreenState();
}

class _VolunteerMainScreenState
    extends State<VolunteerMainScreen> {

  int currentIndex = 0;

  final List<Widget> screens = [

    const TaskListScreen(),

    const MyApplicationsScreen(),

    const ProfileScreen(),
  ];

  final List<String> titles = [

    'Volunteer Tasks',

    'My Applications',

    'Profile',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),

      body: screens[currentIndex],

      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Applications',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}