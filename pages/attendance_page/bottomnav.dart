import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/calender/calender_widget.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/pages/attendance_page/attendance_page_widget.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

Future<String?> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _navigateToPage(int index) async {
    final token = await getAuthToken();
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to Home page
        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmployepageWidget(token: token),
            ),
          );
        }
        break;
      case 1:
        // Navigate to Attendance page
        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AttendancePageWidget(token: token),
            ),
          );
        }
        break;
      case 2:
        // Navigate to Calendar page
        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CalenderWidget(),
            ),
          );
        }
        break;
    }
  }

  @override
Widget build(BuildContext context) {
  return ClipRRect(
     borderRadius:  const BorderRadius.only(topLeft:Radius.circular(15),topRight: Radius.circular(15)),
    child: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _navigateToPage,
      backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
      selectedItemColor: FlutterFlowTheme.of(context).primaryBackground,
      unselectedItemColor: FlutterFlowTheme.of(context).primaryBackground,
      elevation: 0.0,
      items: [
        _buildNavigationBarItem(
          context,
          icon: Icons.home,
          label: 'Home',
          index: 0,
        ),
        _buildNavigationBarItem(
          context,
          icon: Icons.access_time,
          label: 'Attendance',
          index: 1,
        ),
        _buildNavigationBarItem(
          context,
          icon: Icons.calendar_today,
          label: 'Calendar',
          index: 2,
        ),
      ],
    ),
  );
}


  BottomNavigationBarItem _buildNavigationBarItem(BuildContext context,
      {required IconData icon, required String label, required int index}) {
    bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? FlutterFlowTheme.of(context).orangePantone
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        child: Icon(
          icon,
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
      ),
      label: label,
    );
  }
}