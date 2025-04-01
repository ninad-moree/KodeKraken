// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kode_kraken/constants/color_constants.dart';
import 'package:kode_kraken/features/teacher_view/widgets/custom_textformfield.dart';
// import 'package:kode_kraken/features/login/ui/welcome.dart';

class AddAssignmentPage extends StatelessWidget {
  const AddAssignmentPage({
    super.key,
    required this.subject,
    required this.batch,
  });

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
          (languageController.text == "cpp17" || languageController.text == "python") &&
          numberController.text != '' &&
          testCasesController.text != '' &&
          titleController.text != '') {
        var data = (await firestore.collection('batches').doc(batch).get()).data();
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
        title: const Text(
          "Add Assignment",
          style: TextStyle(
            color: ColorConstants.kPrimaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField(
              //   decoration: const InputDecoration(
              //     hintText: 'Number',
              //   ),
              //   controller: numberController,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: CustomTextFormField(controller: numberController, labelText: 'Number')),
                  const SizedBox(width: 30),
                  Expanded(child: CustomTextFormField(controller: titleController, labelText: 'Title')),
                ],
              ),
              const SizedBox(height: 24),
              // CustomTextFormField(controller: titleController, labelText: 'Title'),
              // const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.lightYellow),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextField(
                    cursorColor: ColorConstants.kPrimaryColor,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(child: CustomTextFormField(controller: subjectController, labelText: 'Subject')),
                  const SizedBox(width: 30),
                  Expanded(child: CustomTextFormField(controller: languageController, labelText: 'Language')),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: CustomTextFormField(controller: testCasesController, labelText: 'Testcases')),
                  const SizedBox(width: 30),
                  Expanded(child: CustomTextFormField(controller: expectedOutputController, labelText: 'Expected Output')),
                ],
              ),
              const SizedBox(height: 24),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     onPressed: () => submitData(),
              //     child: const Text("Submit"),
              //   ),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.kPrimaryColor,
                    elevation: 5, // Elevation of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () => submitData(),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: ColorConstants.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
