// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kode_kraken/features/teacher_view/ui/batch_display.dart';
import 'package:kode_kraken/features/teacher_view/ui/teacher_batch_display.dart';

class TeacherOption extends StatelessWidget {
  const TeacherOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BatchDisplay()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('View or Edit Assignment', style: TextStyle(color: Colors.white, fontSize: 25)),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'OR',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                ),
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeacherBatchDisplay()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Grade Student Assignment', style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
