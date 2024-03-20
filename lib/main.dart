import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:vtag/firebase_options.dart";
import "package:vtag/pages/network_screen.dart";
import "package:vtag/services/auth_gate.dart";
import "package:vtag/services/auth_service.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
