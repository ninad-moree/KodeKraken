// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kode_kraken/features/student_view/ui/subject_display.dart';
import '../../student_view/bloc/student_page_bloc.dart';
import '../bloc/login_bloc.dart';

class LoginPageStudent extends StatefulWidget {
  const LoginPageStudent({super.key});

  static const routeName = '/student-login';

  @override
  State<LoginPageStudent> createState() => _LoginPageStudentState();
}

class _LoginPageStudentState extends State<LoginPageStudent> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Login'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 150,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 150,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ButtonTheme(
                height: 56,
                child: BlocProvider(
                  create: (context) => LoginBloc(),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => StudentPageBloc()
                                    ..getAllSubjects(state.student!),
                                  child:
                                      SubjectDisplay(student: state.student!),
                                )));
                      }
                      if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return ElevatedButton(
                          onPressed: () {},
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              StudentLoginButtonClickedEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
