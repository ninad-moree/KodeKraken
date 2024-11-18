// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kode_kraken/constants/color_constants.dart';
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
      backgroundColor: ColorConstants.kBackgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.61,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: ColorConstants.kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      "KodeKraken",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 100),
                    Text(
                      "Start your",
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    Text(
                      "journey with us.",
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Discover the world's best",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "student submisson platform for",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "plagerism detection and versioning.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 20, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 32),
                    ),
                    Text(
                      "Don't have an account? Register",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 60),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: BlocProvider(
                        create: (context) => LoginBloc(),
                        child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => StudentPageBloc()..getAllSubjects(state.student!),
                                    child: SubjectDisplay(student: state.student!),
                                  ),
                                ),
                              );
                            }
                            if (state is LoginFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                            }
                          },
                          builder: (context, state) {
                            // if (state is LoginLoading) {
                            //   return ElevatedButton(
                            //     onPressed: () {},
                            //     child: CircularProgressIndicator(color: Colors.white),
                            //   );
                            // }
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.125,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: ColorConstants.kPrimaryColor,
                                  shadowColor: Colors.grey,
                                  elevation: 5, // Elevation of the button
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                ),
                                onPressed: () {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    StudentLoginButtonClickedEvent(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
