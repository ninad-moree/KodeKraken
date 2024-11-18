// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kode_kraken/features/login/ui/login_page_student.dart';
import 'package:kode_kraken/features/login/ui/login_page_teacher.dart';

class WelcomePage extends StatelessWidget {
  //const WelcomePage({Key key}) : super(key: key);

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KodeKraken'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 56.0,
              child: Image.asset('assets/images/welcome.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageTeacher()));
                  },
                  child: const Text('Teacher', style: TextStyle(color: Colors.white, fontSize: 25))),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageStudent()));
                  },
                  child: const Text('Student', style: TextStyle(color: Colors.white, fontSize: 25))),
            ),
          ],
        ),
      ),
    );
  }
}
