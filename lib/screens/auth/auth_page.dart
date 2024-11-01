import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodle/blocs/auth/auth_bloc.dart';
import 'package:moodle/screens/auth/widgets/text_form_widget.dart';
import 'package:moodle/screens/students/students_page.dart';
import 'package:moodle/screens/teachers/teachers_page.dart';

enum UserRole { student, teacher }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserRole? selectedRole;
  bool isObscured = false;
  bool isLogin = false;
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Page"),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            if (state.role == UserRole.teacher) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const TeachersPage();
                  },
                ),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return StudentsPage();
                  },
                ),
              );
            }
          } else if (state is Autherror) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFormWidget(
                  controller: emailController,
                  text: "Enter your email",
                  keyBoardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFormWidget(
                  controller: passwordController,
                  text: "Enter your password",
                  keyBoardType: TextInputType.text,
                  isObscured: isObscured,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    icon: Icon(
                      isObscured
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isLogin)
                  DropdownButton<UserRole>(
                    hint: const Text("Choose your role"),
                    value: selectedRole,
                    items: const [
                      DropdownMenuItem(
                        value: UserRole.student,
                        child: Text("Sign up as a Student"),
                      ),
                      DropdownMenuItem(
                        value: UserRole.teacher,
                        child: Text("Sign up as a Teacher"),
                      ),
                    ],
                    onChanged: (UserRole? value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: isLogin
                              ? "Already have an account?"
                              : "Don't have an account?",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin ? "Login" : "Sign Up",
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedRole != null && isLogin) {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthSignUpRequested(
                          emailController.text,
                          passwordController.text,
                          selectedRole!,
                        ),
                      );
                    } else if (!isLogin) {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthLoginRequested(
                          emailController.text,
                          passwordController.text,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please, select a role"),
                        ),
                      );
                    }
                  },
                  child: Text(isLogin ? "Sign up" : "Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
