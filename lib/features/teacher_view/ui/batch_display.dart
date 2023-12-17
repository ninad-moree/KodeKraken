import 'package:flutter/material.dart';
import 'package:kode_kraken/features/teacher_view/ui/assignment_batch_subject.dart';
import 'package:kode_kraken/services/database.dart';

class BatchDisplay extends StatelessWidget {
  const BatchDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Batches')),
      body: FutureBuilder(
        future: Database.getBatches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AssignmentBatchSubject(
                            batch: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Center(
                        child: Text(
                          snapshot.data![index],
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No batches found."),
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
