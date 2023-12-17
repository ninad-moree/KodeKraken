import 'package:flutter/material.dart';
import 'package:kode_kraken/features/teacher_view/ui/submitted_assig.dart';

class RollNumberPage extends StatelessWidget {
  final List<String> rollNumbers;

  const RollNumberPage({super.key, required this.rollNumbers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roll Numbers'),
      ),
      body: ListView.builder(
        itemCount: rollNumbers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(rollNumbers[index]),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SubmittedAssignments(rollNumber: rollNumbers[index])),
              );
            },
          );
        },
      ),
    );
  }
}
