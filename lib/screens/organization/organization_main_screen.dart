import 'package:flutter/material.dart';

import '../shared/profile_screen.dart';
import '../shared/task_list_screen.dart';
import 'create_task_screen.dart';

class OrganizationMainScreen
    extends StatefulWidget {

  const OrganizationMainScreen({
    super.key,
  });

  @override
  State<OrganizationMainScreen>
      createState() =>
          _OrganizationMainScreenState();
}

class _OrganizationMainScreenState
    extends State<OrganizationMainScreen> {

  int currentIndex = 0;

  final List<Widget> screens = [

    const TaskListScreen(),

    const ProfileScreen(),
  ];

  final List<String> titles = [

    'Organization Tasks',

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

      floatingActionButton:
          currentIndex == 0
              ? FloatingActionButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const CreateTaskScreen(),
                      ),
                    );
                  },
                  child:
                      const Icon(Icons.add),
                )
              : null,

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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}