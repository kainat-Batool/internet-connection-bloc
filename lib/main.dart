// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc_in_flutter/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_in_flutter/blocs/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetBloc(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetGainedState) {
                Get.snackbar('Gained Connection ', 'Connected!');
              } else if (state is InternetLostState) {
                Get.snackbar('Lose Connection ', 'Not Connected!');
              }
            },
            builder: (context, state) {
              if (state is InternetGainedState) {
                return Text("Connected!");
              } else if (state is InternetLostState) {
                return Text('Not Connected!');
              } else {
                return Text('Loading...');
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar('Hello', 'World');
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
