// ignore_for_file: prefer_const_declarations
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kode_kraken/features/login/ui/welcome.dart';
import 'features/login/bloc/login_bloc.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KodeKraken',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (ctx) => const WelcomePage(),
          },
        ),
      ),
    );
  }
}

/*
  Student:
    Id - test@gmail.com
    pwd - pass@123

  Teacher:
    Id- teacher
    pwd - pass@123
*/
