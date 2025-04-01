// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kode_kraken/features/teacher_view/ui/teacher_option.dart';
import '../../../constants/color_constants.dart';
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
      backgroundColor: ColorConstants.kBackgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.61,
          decoration: BoxDecoration(
            color: ColorConstants.grey,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                width: MediaQuery.of(context).size.width * 0.21,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login_bg.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          color: ColorConstants.black,
                          'assets/images/logo.svg',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const Text(
                          'KodeKraken',
                          style: TextStyle(
                            color: ColorConstants.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Discover the world's best student submission platform for plagiarism detection and versioning.",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.grey,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 20, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(150),
                        ),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.start,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: ColorConstants.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.start,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: ColorConstants.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: BlocProvider(
                        create: (context) => LoginBloc(),
                        child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => StudentPageBloc()..getAllSubjects(state.student!),
                                    child: TeacherOption(),
                                  ),
                                ),
                              );
                            }
                            if (state is LoginFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              // return ElevatedButton(
                              //   onPressed: () {},
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: CircularProgressIndicator(
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // );
                            }
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.kPrimaryColor,
                                  elevation: 5, // Elevation of the button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    TeacherLoginButtonClickedEvent(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: ColorConstants.black,
                                    fontSize: 24,
                                  ),
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
