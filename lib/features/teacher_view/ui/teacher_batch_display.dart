import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kode_kraken/features/teacher_view/ui/roll_number_page.dart';

import '../../../constants/color_constants.dart';

class Batch {
  String name;
  List<String> rollNumbers;

  Batch({required this.name, required this.rollNumbers});
}

class TeacherBatchDisplay extends StatelessWidget {
  TeacherBatchDisplay({super.key});

  final batches = [
    Batch(name: 'E1', rollNumbers: [
      '21101',
      '21102',
      '21103',
      '21104',
      '21105',
      '21106',
      '21107',
      '21108',
      '21109',
      '21110'
    ]),
    Batch(name: 'F1', rollNumbers: [
      '21111',
      '21112',
      '21113',
      '21114',
      '21115',
      '21116',
      '21117',
      '21118',
      '21119',
      '21120'
    ]),
    Batch(name: 'G1', rollNumbers: [
      '21121',
      '21122',
      '21123',
      '21124',
      '21125',
      '21126',
      '21127',
      '21128',
      '21129',
      '21130'
    ]),
    Batch(name: 'H1', rollNumbers: [
      '21131',
      '21132',
      '21133',
      '21134',
      '21135',
      '21136',
      '21137',
      '21138',
      '21139',
      '21140'
    ]),
    Batch(name: 'E2', rollNumbers: [
      '21201',
      '21202',
      '21203',
      '21204',
      '21205',
      '21206',
      '21207',
      '21208',
      '21209',
      '21210'
    ]),
    Batch(name: 'F2', rollNumbers: [
      '21211',
      '21212',
      '21213',
      '21214',
      '21215',
      '21216',
      '21217',
      '21218',
      '21219',
      '21220'
    ]),
    Batch(name: 'G2', rollNumbers: [
      '21221',
      '21222',
      '21223',
      '21224',
      '21225',
      '21226',
      '21227',
      '21228',
      '21229',
      '21230'
    ]),
    Batch(name: 'H2', rollNumbers: [
      '21231',
      '21232',
      '21233',
      '21234',
      '21235',
      '21236',
      '21237',
      '21238',
      '21239',
      '21240'
    ]),
    Batch(name: 'E3', rollNumbers: [
      '21301',
      '21302',
      '21303',
      '21304',
      '21305',
      '21306',
      '21307',
      '21308',
      '21309',
      '21310'
    ]),
    Batch(name: 'F3', rollNumbers: [
      '21311',
      '21312',
      '21313',
      '21314',
      '21315',
      '21316',
      '21317',
      '21318',
      '21319',
      '21320'
    ]),
    Batch(name: 'G3', rollNumbers: [
      '21321',
      '21322',
      '21323',
      '21324',
      '21325',
      '21326',
      '21327',
      '21328',
      '21329',
      '21330'
    ]),
    Batch(name: 'H3', rollNumbers: [
      '21331',
      '21332',
      '21333',
      '21334',
      '21335',
      '21336',
      '21337',
      '21338',
      '21339',
      '21340'
    ]),
    Batch(name: 'E4', rollNumbers: [
      '21401',
      '21402',
      '21403',
      '21404',
      '21405',
      '21406',
      '21407',
      '21408',
      '21409',
      '21210'
    ]),
    Batch(name: 'F4', rollNumbers: [
      '21411',
      '21412',
      '21413',
      '21414',
      '21415',
      '21416',
      '21417',
      '21418',
      '21419',
      '21220'
    ]),
    Batch(name: 'G4', rollNumbers: [
      '21421',
      '21422',
      '21423',
      '21424',
      '21425',
      '21426',
      '21427',
      '21428',
      '21429',
      '21230'
    ]),
    Batch(name: 'H4', rollNumbers: [
      '21431',
      '21432',
      '21433',
      '21434',
      '21435',
      '21436',
      '21437',
      '21438',
      '21439',
      '21240'
    ]),
  ];

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
                  'Batches',
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.5,
        ),
        itemCount: batches.length,
        itemBuilder: (BuildContext context, int index) {
          final batch = batches[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => RollNumberPage(
                    rollNumbers: batch.rollNumbers,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: ColorConstants.grey,
                shadowColor: ColorConstants.lightYellow,
                elevation: 12,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        batch.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:kode_kraken/features/teacher_view/ui/roll_number_page.dart';
// import 'package:kode_kraken/models/student.dart';
// import 'package:kode_kraken/models/student_assignment.dart';
// import 'package:kode_kraken/services/database.dart';

// class TeacherBatchDisplay extends StatelessWidget {
//   const TeacherBatchDisplay({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Batches')),
//       body: FutureBuilder(
//         future: Database.getBatches(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   childAspectRatio: 1.5,
//                 ),
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               RollNumberPage(rollNumbers: ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       child: Center(
//                         child: Text(
//                           snapshot.data![index],
//                           style: const TextStyle(
//                             fontSize: 24,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: Text("No batches found."),
//               );
//             }
//           }
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }

