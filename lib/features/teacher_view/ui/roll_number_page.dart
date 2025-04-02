// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kode_kraken/features/teacher_view/ui/submitted_assig.dart';

import '../../../constants/color_constants.dart';

class RollNumberPage extends StatelessWidget {
  final List<String> rollNumbers;

  const RollNumberPage({super.key, required this.rollNumbers});

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
            const Expanded(
              child: Center(
                child: Text(
                  'Roll Numbers',
                  style: TextStyle(
                    color: ColorConstants.kPrimaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              color: ColorConstants.kBackgroundColor,
              'assets/images/logo.svg',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            const Text(
              'KodeKraken',
              style: TextStyle(
                color: ColorConstants.kBackgroundColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: rollNumbers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              rollNumbers[index],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => SubmittedAssignments(rollNumber: rollNumbers[index])),
              );
            },
          );
        },
      ),
    );
  }
}
