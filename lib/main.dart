import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodle/blocs/auth/auth_bloc.dart';
import 'package:moodle/repositories/auth_repo.dart';
import 'package:moodle/screens/auth/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}