import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login-page.dart';

class LogoutScreen extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userName');
    await prefs.remove('userEmail');

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<Map<String, String?>> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('userName'),
      'email': prefs.getString('userEmail'),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: _getUserInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text('Logout')),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final userName = snapshot.data!['name'] ?? 'No Name';
        final userEmail = snapshot.data!['email'] ?? 'No Email';

        return Scaffold(
          appBar: AppBar(title: Text('Logout')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: $userName', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('Email: $userEmail', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _logout(context),
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
