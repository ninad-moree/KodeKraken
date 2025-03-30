// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kode_kraken/constants/color_constants.dart';
import 'package:kode_kraken/features/login/ui/login_page_student.dart';
import 'package:kode_kraken/features/login/ui/login_page_teacher.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kBackgroundColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.61,
          decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // STUDENT SIDE
              Stack(
                children: [
                  Image.asset(
                    'assets/images/student.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.3037,
                    height: MediaQuery.of(context).size.height * 0.75,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPageStudent(),
                              ),
                            );
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => ProfilePageStudent(),
                            //   ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: ColorConstants.kPrimaryColor,
                            shadowColor: Colors.grey,
                            elevation: 5, // Elevation of the button
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            'Student',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // VERTICAL DIVIDER
              Container(
                width: 1,
                height: MediaQuery.of(context).size.height * 0.75,
                color: Colors.black,
              ),

              // TEACHER SIDE
              Stack(
                children: [
                  Image.asset(
                    'assets/images/teacher.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.3038,
                    height: MediaQuery.of(context).size.height * 0.75,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageTeacher()));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: ColorConstants.kPrimaryColor,
                            shadowColor: Colors.grey,
                            elevation: 5, // Elevation of the button
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            'Teacher',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     CircleAvatar(
        //       radius: 56.0,
        //       child: Image.asset('assets/images/welcome.png'),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(10),
        //       child: ElevatedButton(
        //         style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
        //         onPressed: () {
        //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageTeacher()));
        //         },
        //         child: const Text(
        //           'Teacher',
        //           style: TextStyle(color: Colors.white, fontSize: 25),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(10),
        //       child: ElevatedButton(
        //         style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
        //         onPressed: () async {
        //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageStudent()));
        //         },
        //         child: const Text(
        //           'Student',
        //           style: TextStyle(color: Colors.white, fontSize: 25),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
