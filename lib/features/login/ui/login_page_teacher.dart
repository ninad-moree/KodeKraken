// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kode_kraken/features/teacher_view/ui/teacher_option.dart';
import '../../student_view/bloc/student_page_bloc.dart';
import '../bloc/login_bloc.dart';

class LoginPageTeacher extends StatefulWidget {
  const LoginPageTeacher({super.key});

  @override
  State<LoginPageTeacher> createState() => _LoginPageTeacherState();
}

class _LoginPageTeacherState extends State<LoginPageTeacher> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Login'),
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
              padding: const EdgeInsets.only(bottom: 10),
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
                                  child: TeacherOption(),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
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
                              TeacherLoginButtonClickedEvent(
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
