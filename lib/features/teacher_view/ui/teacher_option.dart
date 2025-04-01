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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorConstants.kPrimaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BatchDisplay(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'View or Edit Assignment',
                    style: TextStyle(
                      color: ColorConstants.kBackgroundColor,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'OR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorConstants.kPrimaryColor),
                ),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TeacherBatchDisplay(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Grade Student Assignment',
                    style: TextStyle(
                      color: ColorConstants.kBackgroundColor,
                      fontSize: 25,
                    ),
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
