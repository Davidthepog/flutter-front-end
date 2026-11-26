// import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:material_ui/material_ui.dart';

// import 'package:flutter_application_1/main_page.dart';
import 'package:flutter_application_1/features/auth/views/login_page.dart';
import 'package:flutter_application_1/features/dashboard.dart';

//import 'package:http/http.dart' as https;

//var url=Uri.http('https://localhost:7052/api/utenze');

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(home: MainPage());
    // return const MaterialApp(home: LoginPage());
    // return const MaterialApp(home: DashboardPage());
    return const MaterialApp(home: AuthGate());
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final AuthService _auth = AuthService();

  late Future<bool> _authCheck;

  @override
  void initState() {
    super.initState();

    _authCheck = _auth.hasRefreshToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authCheck,
      builder: (context, snapshot) {
        // Controllo ancora in corso
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Token presente
        if (snapshot.data == true) {
          return const DashboardPage();
        }

        // Token assente
        return const LoginPage();
      },
    );
  }
}
