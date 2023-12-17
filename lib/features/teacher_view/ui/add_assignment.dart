// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:kode_kraken/features/login/ui/welcome.dart';

class AddAssignmentPage extends StatelessWidget {
  const AddAssignmentPage(
      {super.key, required this.subject, required this.batch});
  final String subject;
  final String batch;

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController expectedOutputController = TextEditingController();
    TextEditingController languageController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController testCasesController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    final firestore = FirebaseFirestore.instance;

    void submitData() async {
      if (subjectController.text != '' &&
          (subjectController.text == "DSL" ||
              subjectController.text == "OOP" ||
              subjectController.text == "DSA" ||
              subjectController.text == "DBMS" ||
              subjectController.text == "OS" ||
              subjectController.text == "SE") &&
          descriptionController.text != '' &&
          expectedOutputController.text != '' &&
          languageController.text != '' &&
          (languageController.text == "cpp17" ||
              languageController.text == "python") &&
          numberController.text != '' &&
          testCasesController.text != '' &&
          titleController.text != '') {
        var data =
            (await firestore.collection('batches').doc(batch).get()).data();
        data!['subjects'][subjectController.text].add({
          'description': descriptionController.text,
          'expectedOutput': expectedOutputController.text,
          'language': languageController.text,
          'number': int.parse(numberController.text),
          'testCases': testCasesController.text,
          'title': titleController.text,
        });
        await firestore.collection('batches').doc(batch).update(data);
        descriptionController.clear();
        expectedOutputController.clear();
        languageController.clear();
        numberController.clear();
        testCasesController.clear();
        titleController.clear();
        subjectController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Assignment Added"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Assignment"),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const WelcomePage(),
        //         ),
        //       );
        //     },
        //     child: const Text(
        //       "Go To Welcome Page",
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Number',
                ),
                controller: numberController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                controller: titleController,
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                  ),
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Subject',
                ),
                controller: subjectController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Language',
                ),
                controller: languageController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Testcases',
                ),
                controller: testCasesController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Expected Output',
                ),
                controller: expectedOutputController,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => submitData(),
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
