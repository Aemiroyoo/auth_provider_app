import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => AuthProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return MaterialApp(
          title: 'Login Provider App',
          theme: ThemeData(primarySwatch: Colors.green),
          home: auth.currentUser != null ? HomeScreen() : LoginScreen(),
        );
      },
    );
  }
}
