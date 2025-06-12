// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kode_kraken/features/teacher_view/ui/batch_display.dart';
import 'package:kode_kraken/features/teacher_view/ui/teacher_batch_display.dart';

import '../../../constants/color_constants.dart';

class TeacherOption extends StatelessWidget {
  const TeacherOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              color: ColorConstants.kPrimaryColor,
              'assets/images/logo.svg',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            const Text(
              'KodeKraken',
              style: TextStyle(
                color: ColorConstants.kPrimaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.61,
          decoration: BoxDecoration(border: Border.all(color: Colors.transparent), borderRadius: BorderRadius.circular(25)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3037,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/prof_teach.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3037,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.kPrimaryColor),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const BatchDisplay(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'View or Edit Assignment',
                              style: TextStyle(
                                color: ColorConstants.kBackgroundColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TeacherBatchDisplay(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Grade Student Assignment',
                              style: TextStyle(
                                color: ColorConstants.kBackgroundColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 60),
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 55,
                      //   child: OutlinedButton(
                      //     onPressed: () async {
                      //       Navigator.of(context).push(
                      //         MaterialPageRoute(
                      //           builder: (context) => const Statistics(),
                      //         ),
                      //       );
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: ColorConstants.kPrimaryColor,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //     ),
                      //     child: const Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: Text(
                      //         'View Student Data',
                      //         style: TextStyle(
                      //           color: ColorConstants.kBackgroundColor,
                      //           fontSize: 20,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
