// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kode_kraken/constants/color_constants.dart';
import 'package:kode_kraken/features/login/ui/login_page_student.dart';
import 'package:kode_kraken/features/login/ui/login_page_teacher.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                color: ColorConstants.kPrimaryColor,
                'assets/images/logo.svg',
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              const Text(
                'KodeKraken',
                style: TextStyle(
                  color: ColorConstants.kPrimaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: ColorConstants.kBackgroundColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.61,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // STUDENT SIDE
              InkWell(
                onTap: () {
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3037,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/student.png'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                ),
              ),

              // VERTICAL DIVIDER
              Container(
                width: 1,
                height: MediaQuery.of(context).size.height * 0.75,
                color: Colors.black,
              ),

              // TEACHER SIDE
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPageTeacher(),
                    ),
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfilePageStudent(),
                  //   ),
                  // );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3037,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/teacher.png'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
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
