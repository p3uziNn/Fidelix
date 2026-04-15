import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/user_type_screen.dart';
import 'screens/home_cliente.dart';
import 'screens/home_comerciante.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // tela inicial
      initialRoute: '/userType',

      routes: {
        '/userType': (context) => const UserTypeScreen(),
        '/login': (context) => const LoginScreen(),

        // 🔥 AGORA SIM ATIVAS
        '/homeCliente': (context) => const HomeClienteScreen(),
        '/homeComerciante': (context) => const HomeComercianteScreen(),
      },
    );
  }
}
